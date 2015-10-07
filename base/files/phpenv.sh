#!/usr/bin/env bash
# The MIT License
#
# Copyright (c) 2011 Christoph Hochstrasser
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

set -e

RBENV_REPO="https://github.com/sstephenson/rbenv.git"

phpenv_script() {
    local root="$1"

    cat <<SH
#!/usr/bin/env bash
export PHPENV_ROOT=\${PHPENV_ROOT:-'$root'}
export RBENV_ROOT="\$PHPENV_ROOT"
exec "\$RBENV_ROOT/libexec/rbenv" "\$@"
SH
}

PHPENV_ROOT="$HOME/.phpenv"

echo "Installing phpenv in $PHPENV_ROOT"
    git clone "$RBENV_REPO" "$PHPENV_ROOT" > /dev/null

sed -i -e 's/rbenv/phpenv/g' "$PHPENV_ROOT"/completions/rbenv.{bash,zsh}
sed -i --separate 's/\.rbenv-version/.phpenv-version/g' "$PHPENV_ROOT"/libexec/rbenv-local
sed -i --separate 's/\.rbenv-version/.phpenv-version/g' "$PHPENV_ROOT"/libexec/rbenv-version-file
sed -i --separate 's/\.ruby-version/.php-version/g' "$PHPENV_ROOT"/libexec/rbenv-local
sed -i --separate 's/\.ruby-version/.php-version/g' "$PHPENV_ROOT"/libexec/rbenv-version-file
sed -i -e 's/\(^\|[^/]\)rbenv/\1phpenv/g' "$PHPENV_ROOT"/libexec/rbenv-init
sed -i -e 's/\phpenv-commands/rbenv-commands/g' "$PHPENV_ROOT"/libexec/rbenv-init
sed -i -e 's/\Ruby/PHP/g' "$PHPENV_ROOT"/libexec/rbenv-which

phpenv_script "$PHPENV_ROOT" > "$PHPENV_ROOT/bin/phpenv"
chmod +x "$PHPENV_ROOT/bin/phpenv"

echo "export PATH=\"${PHPENV_ROOT}/bin:"'$PATH"' >> /root/.bashrc
echo 'eval "$(phpenv init -)"' >> /root/.bashrc
