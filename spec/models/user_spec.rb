RSpec.describe 'User' do
    describe 'when minimum attributes are provided' do
        let(:attrs) {
            {
                first_name: 'joseph',
                last_name: 'senecal',
                zip_code: nil,
                email: 'joe.senecal@email.io',
                password: 'password1234'
            }
        }

        it 'saves a record' do
            # require 'pry': binding.pry
            new_user = User.create!(**attrs)
            expect(new_user.id).not_to be nil
        end
    end

    describe 'Unit Tests' do
        describe '#full_name' do

            let(:new_user) {FactoryBot.create(:user)}

            it "pulls the first_name and last_name from a user's record, concatinates and retusn them" do
                expected = "#{new_user.first_name} #{new_user.last_name}"

                expect(new_user.full_name).to match expected
            end
        end
    end
end