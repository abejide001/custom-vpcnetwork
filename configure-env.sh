
function configureEnv {
        touch .env
        echo "DATABASE_NAME=authorshavendb"
        echo "DATABASE_HOST=localhost"
        echo "DATABASE_DIALECT=postgres"
        echo "TEST_DATABASE_NAME=authorshaven_testdb"
        echo "APP_BASE_URL=http://localhost:3000"
        echo "SECRET_KEY=dsfghjyuiyiyuyiyguyijhgkgjfhjgh"
        echo "JWT_SECRET_KEY='p@$$W0rd'"
        echo "FACEBOOK_APP_ID=441096529762388"
        echo "FACEBOOK_APP_SECRET=a71271aab7cdf2152da30e5225941af2"
        echo "FACEBOOK_CALLBACK_URL='http://localhost:3000/api/v1/auth/facebook/callback'"

        echo "GOOGLE_CLIENT_ID=616688532144-l0q33pc0pqk4i2e2s8be0f8cneolmo48.apps.googleusercontent.com"
        echo "GOOGLE_CLIENT_SECRET=2aHJ-7BzjojBh-DEe6Nti4m8"
        echo "GOOGLE_CALLBACK_URL='http://localhost:3000/api/v1/auth/google/callback'"

        echo "LINKEDIN_KEY=86tkgus9r37c7x"
        echo "LINKEDIN_SECRET=wxeMoiDz5B4emVmf"
        echo "LINKEDIN_CALLBACK_URL='http://localhost:3000/api/v1/auth/linkedin/callback'"

        echo "TWITTER_KEY=JqIc0lGdLNzza7ahF8JtbFbFP"
        echo "TWITTER_SECRET=tDyPBtz65tNtu5e8I79iJ8PyD2otx4YS863MPRqHcP5vm8YCOM"
        echo "TWITTER_CALLBACK_URL='http://localhost:3000/api/v1/auth/twitter/callback'"
        echo "ADMIN_PASSWORD=adminPassword"
        echo "ADMIN_FIRSTNAME=adminFirstname"
        echo "ADMIN_LASTNAME=adminLastname"
        echo "ADMIN_EMAIL_1=ADMIN_EMAIL_1"
}
configureEnv >> .env