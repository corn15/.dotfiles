# Linux functions.

# Make re-sourcing safe even if `disks` used to be an alias or function.
unset -f disks 2>/dev/null
unalias disks 2>/dev/null
disks() {
  echo "╓───── m o u n t . p o i n t s"
  echo "╙────────────────────────────────────── ─ ─ "
  if command -v lsblk >/dev/null 2>&1; then
    lsblk -a
  else
    echo "lsblk not found"
  fi

  echo ""
  echo "╓───── d i s k . u s a g e"
  echo "╙────────────────────────────────────── ─ ─ "
  df -h
}
