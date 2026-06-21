ssh-keygen -t ed25519 -C "ваш_email@example.com"
eval (ssh-agent -c)
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
copy and add to git ssh keys
test
ssh -T git@github.com

change to ssh~
git remote set-url origin git@github.com:randomniht/dotfiles.git
git config --global user.email "%email%"
git config --global user.name "%name%"

add commit push
and/or othr repo
