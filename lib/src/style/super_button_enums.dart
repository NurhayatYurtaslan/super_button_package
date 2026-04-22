/// Visual style intent for [SuperButton].
enum SuperButtonVariant {
  filled,
  tonal,
  outlined,
  text,
  elevated,
  gradient,
  glass,
  neumorphic,
  icon,
  fab,
  link,
  destructive,
}

/// Spacing, typography, and min tap target scale for [SuperButton].
enum SuperButtonSize { xs, sm, md, lg, xl }

/// Corner / outline treatment for [SuperButton].
enum SuperButtonShape { rounded, pill, stadium, circle, squircle, cutCorner }

/// Semantic intent (maps to [ColorScheme] roles in later phases).
enum SuperButtonTone { primary, neutral, success, warning, danger }
