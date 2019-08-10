require 'rails_helper'

RSpec.describe Todo, type: :model do

  let(:todo) { FactoryBot.create(:todo) }
  let(:in_progress_todo) { FactoryBot.create(:todo, :in_progress) }
  let(:done_todo) { FactoryBot.create(:todo, :done) }

  describe 'associations' do
    it { should belong_to(:project).class_name('Project') }
    it { should belong_to(:developer).class_name('User') }
  end

  describe 'validations' do
    subject { build(:todo) }
    it { should validate_presence_of(:description) }
  end

   describe '#project' do
    it 'validates presence' do
      todo = Todo.new
      todo.developer = FactoryBot.create(:user)
      todo.valid?
      todo.errors[:project].should include('must exist')
    end
  end

   describe '#developer' do
    it 'validates presence' do
      todo = Todo.new
      todo.project = FactoryBot.create(:project)
      todo.valid?
      todo.errors[:user].should_not include('must exist')
    end
  end

  describe 'Callbacks' do
    subject { FactoryBot.create(:todo) }
    context 'when created' do
      it 'should have assigned status by default' do
        subject.save
        expect(subject.status).to eq('assigned')
      end

      it 'should keep its defined status' do
        subject.status = 'in_progress'
        subject.save
        expect(subject.status).to eq('in_progress')
      end
    end
  end
end
