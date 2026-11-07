#!/usr/bin/env bash
# Checks the built site under _site/ (run `bundle exec jekyll build` first).
# Exits non-zero on the first failure.
set -u

SITE="${SITE:-_site}"
fail() { echo "FAIL: $*" >&2; exit 1; }

test -d "$SITE" || fail "$SITE/ does not exist; build the site first"

# The home page has the hero.
[ "$(grep -c 'class="hero' "$SITE/index.html")" -ge 1 ] || fail "no .hero in $SITE/index.html"

# Every main page has the top navigation bar.
missing=$(grep -L 'site-nav' "$SITE/index.html" "$SITE/software/index.html" \
  "$SITE/courses/index.html" "$SITE/talk/index.html")
[ -z "$missing" ] || fail "no site-nav in: $missing"

# The projects collection is gone.
test ! -e "$SITE/projects" || fail "$SITE/projects still exists"

# No traces of the old Gradfolio theme in the compiled CSS.
if grep -E '#60c17d|Work Sans' "$SITE/assets/css/main.css"; then
  fail "old theme colour or font in $SITE/assets/css/main.css"
fi

# The talks palette: hero gradient and a dark-mode variant.
for k in '#0f2942' '#1c4e80' '#2e86ab' 'prefers-color-scheme: *dark'; do
  grep -qE "$k" "$SITE/assets/css/main.css" || fail "'$k' missing from main.css"
done

# No headings inside <head>.
if sed -n '/<head>/,/<\/head>/p' "$SITE/index.html" | grep -qE '<h[1-6]'; then
  fail "heading inside <head> of $SITE/index.html"
fi

echo "OK: site checks passed"
