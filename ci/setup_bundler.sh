if [[ -s Gemfile ]] && {
  ! builtin command -v bundle >/dev/null ||
  builtin command -v bundle | GREP_OPTIONS="" \command \grep $rvm_path/bin/bundle >/dev/null
}
then
  printf "%b" "The rubygem 'bundler' is not installed. Installing it now.\n"
  gem install bundler
fi
if [[ -s Gemfile ]] && builtin command -v bundle >/dev/null
then
  bundle install | GREP_OPTIONS="" \command \grep -vE '^Using|Your bundle is complete'
fi
