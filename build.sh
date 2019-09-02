git clone https://github.com/cybertec-postgresql/today-i-learned.git today-i-learned
cd today-i-learned

curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | bash
yum install git-lfs
git lfs install

git clone https://github.com/cybertec-postgresql/today-i-learned-content.git content
cd content
git checkout $NOW_GITHUB_COMMIT_REF
cd ..

yarn
yarn build
