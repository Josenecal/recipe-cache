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
end