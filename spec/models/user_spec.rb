require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { FactoryBot.create(:user) }
  let(:admin_user) { FactoryBot.create(:user,:admin) }

  it { should define_enum_for(:role).with([:admin, :developer]) }

  it do
    should define_enum_for(:role).
      with_values([:admin, :developer])
  end

  describe 'Callbacks' do
    subject { User.new(email: 'demo@xyz.com') }
    context 'when initialized' do
      it 'should have assigned developer role by default' do
        expect(subject.role).to eq('developer')
      end

      it 'should keep its defined status' do
        subject.save
        expect(subject.role).to eq('developer')
      end
    end
  end

end
