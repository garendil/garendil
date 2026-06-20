#!/bin/bash
# Detecta referencias sueltas en CURRENT/*.md
# Uso: bash scripts/validate-refs.sh

ERRORS=0

echo "=== Validando referencias cruzadas en CURRENT/ ==="

# Referencias DEC sin formato link
LOOSE=$(grep -rn "ver DEC-\|\*\*DEC-[0-9]" CURRENT/ --include="*.md" | grep -v "\[DEC-")
if [ -n "$LOOSE" ]; then
  echo "⚠️  Referencias DEC sueltas encontradas:"
  echo "$LOOSE"
  ERRORS=$((ERRORS+1))
fi

# Links a DECISIONS.md sin ancla
NO_ANCHOR=$(grep -rn "\[DEC-[0-9]*\](CURRENT/DECISIONS\.md)" CURRENT/ --include="*.md" | grep -v "#dec-")
if [ -n "$NO_ANCHOR" ]; then
  echo "⚠️  Links sin ancla encontrados:"
  echo "$NO_ANCHOR"
  ERRORS=$((ERRORS+1))
fi

if [ $ERRORS -eq 0 ]; then
  echo "✅ Todas las referencias tienen formato correcto"
fi

exit $ERRORS
