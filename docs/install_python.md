# Setup Python Environment (for Linux)

## Install Pyenv.

Reference: [install method page in Pyenv Readme](https://github.com/pyenv/pyenv?tab=readme-ov-file#automatic-installer)

```bash
curl https://pyenv.run | bash
```

## Load pyenv automatically

Reference: [set-up page in Pyenv Readme](https://github.com/pyenv/pyenv?tab=readme-ov-file#set-up-your-shell-environment-for-pyenv)

```bash
cat <<'EOT' >> ~/.bash_profile
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
EOT

source ~/.bash_profile

pyenv -v
```

## Install and Swhitched global python

Reference: [install-additional-python-versions page in Pyenv Readme](https://github.com/pyenv/pyenv?tab=readme-ov-file#install-additional-python-versions)

```bash
pyenv install -l
pyenv install [The version of python you want to install]
pyenv global [The version of python you installed]
```

if you want to install python 3.9

```bash
pyenv install 3.9
pyenv global 3.9
```

Make sure python is installed

```bash
python -V
```
