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

# Favicons exist and are linked with absolute paths (review fix-1, added after
# issues #5/#6: the old include used relative hrefs to files that never existed).
for f in apple-touch-icon.png favicon-32x32.png favicon-16x16.png; do
  test -s "$SITE/assets/images/$f" || fail "missing $SITE/assets/images/$f"
done
for p in index.html software/index.html courses/index.html talk/index.html; do
  [ "$(grep -c 'href="/assets/images/favicon-32x32.png"' "$SITE/$p")" -eq 1 ] \
    || fail "favicon link missing in $SITE/$p"
done

# Number of cards on each collection page.
count() { grep -o 'class="card"' "$SITE/$1/index.html" | wc -l | tr -d ' '; }
for pc in talk:16 courses:5 software:12; do
  page=${pc%%:*}; want=${pc##*:}; got=$(count "$page")
  [ "$got" -eq "$want" ] || fail "/$page/ has $got cards, expected $want"
done

# Every external URL in the collections returns HTTP 200 (needs network).
if [ "${CHECK_LINKS:-0}" = "1" ]; then
  bad=0
  for u in $(grep -rhoE 'https?://[^ "<>)]+' _talk _courses _software | sort -u); do
    code=$(curl -s -o /dev/null -w '%{http_code}' -L --max-time 30 "$u")
    if [ "$code" != "200" ]; then echo "$code $u" >&2; bad=1; fi
  done
  [ "$bad" -eq 0 ] || fail "broken external links"
  echo "OK: all external links return 200"
fi

echo "OK: site checks passed"
