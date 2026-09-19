#!/usr/bin/env bash
# Downloads every image and video the site currently loads from Framer's CDN
# into ./assets, then rewrites the HTML to point at the local copies.
#
# Run this BEFORE you unpublish the Framer site — once it's gone, so are the files.
#
#   chmod +x fetch-assets.sh && ./fetch-assets.sh
#
# It makes .bak copies of every HTML file before rewriting.
set -euo pipefail

mkdir -p assets/img assets/video
FILES=(index.html visual.html 404.html projects/*.html)

echo "Collecting asset URLs…"
grep -ho 'https://framerusercontent\.com/images/[A-Za-z0-9]*\.\(png\|jpg\)' "${FILES[@]}" | sort -u > /tmp/img.txt
grep -ho 'https://framerusercontent\.com/assets/[A-Za-z0-9]*\.mp4'          "${FILES[@]}" | sort -u > /tmp/vid.txt
echo "  $(wc -l < /tmp/img.txt) images, $(wc -l < /tmp/vid.txt) videos"

while read -r url; do
  name="${url##*/}"
  [ -f "assets/img/$name" ] || { echo "  ↓ $name"; curl -fsSL "$url" -o "assets/img/$name"; }
done < /tmp/img.txt

while read -r url; do
  name="${url##*/}"
  [ -f "assets/video/$name" ] || { echo "  ↓ $name"; curl -fsSL "$url" -o "assets/video/$name"; }
done < /tmp/vid.txt

echo "Rewriting HTML…"
for f in "${FILES[@]}"; do
  cp "$f" "$f.bak"
  case "$f" in
    projects/*) prefix="../assets" ;;
    *)          prefix="assets" ;;
  esac
  # drop Framer's resizing query strings, point at the local files
  sed -i.tmp -E \
    -e "s#https://framerusercontent\.com/images/([A-Za-z0-9]+)\.(png|jpg)(\?[^\"']*)?#${prefix}/img/\1.\2#g" \
    -e "s#https://framerusercontent\.com/assets/([A-Za-z0-9]+)\.mp4(\?[^\"']*)?#${prefix}/video/\1.mp4#g" \
    "$f"
  rm -f "$f.tmp"
  echo "  ✓ $f"
done

echo
echo "Done. Originals saved as *.bak."
echo "NOTE: local files are full resolution — some are very large. Consider"
echo "resizing assets/img before committing, and check the page still looks right."
