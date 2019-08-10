require 'rails_helper'

RSpec.describe Project, type: :model do

  let(:project) { FactoryBot.create(:project) }

  describe 'associations' do
    it { should have_many(:todos).class_name('Todo') }
    it { should have_and_belong_to_many(:developers).class_name('User') }
  end

  describe 'validations' do
    subject { build(:project) }
    it { should validate_presence_of(:title) }
  end

  describe 'Class Methods' do
    describe '.todos_with_status' do
      before do
        todo = FactoryBot.create(:todo)
      end
      it 'should retun hash of todos count with status' do 
        expect(Project.todos_with_status).to be_kind_of(Hash)
      end
    end
  end

end
