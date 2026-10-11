# Draws the FixWitness app icon (white shield with a check on teal) at
# 1024x1024. Writes:
#   assets/icon/icon.png             full icon (iOS, web, legacy Android)
#   assets/icon/icon_foreground.png  shield only, transparent, sized for the
#                                    Android adaptive-icon safe zone
# Then `dart run flutter_launcher_icons` produces every platform size.
Add-Type -AssemblyName System.Drawing
$out = Join-Path $PSScriptRoot '..\assets\icon'
New-Item -ItemType Directory -Force $out | Out-Null

function New-ShieldPath([float]$cx, [float]$top, [float]$w, [float]$h) {
  $p = New-Object System.Drawing.Drawing2D.GraphicsPath
  $l = $cx - $w / 2; $r = $cx + $w / 2; $b = $top + $h
  $p.AddBezier($cx, $top, $cx + $w * 0.22, $top + $h * 0.07, $r - $w * 0.06, $top + $h * 0.07, $r, $top + $h * 0.10)
  $p.AddBezier($r, $top + $h * 0.10, $r, $top + $h * 0.55, $cx + $w * 0.30, $top + $h * 0.85, $cx, $b)
  $p.AddBezier($cx, $b, $cx - $w * 0.30, $top + $h * 0.85, $l, $top + $h * 0.55, $l, $top + $h * 0.10)
  $p.AddBezier($l, $top + $h * 0.10, $l + $w * 0.06, $top + $h * 0.07, $cx - $w * 0.22, $top + $h * 0.07, $cx, $top)
  $p.CloseFigure()
  return $p
}

function Draw-Mark($g, [float]$scale) {
  $cx = 512; $w = 560 * $scale; $h = 660 * $scale; $top = 512 - $h / 2
  $shield = New-ShieldPath $cx $top $w $h
  $g.FillPath([System.Drawing.Brushes]::White, $shield)
  $teal = [System.Drawing.Color]::FromArgb(255, 15, 110, 110)
  $pen = New-Object System.Drawing.Pen $teal, (64 * $scale)
  $pen.StartCap = 'Round'; $pen.EndCap = 'Round'; $pen.LineJoin = 'Round'
  $pts = [System.Drawing.PointF[]]@(
    (New-Object System.Drawing.PointF ($cx - 150 * $scale), ($top + $h * 0.50)),
    (New-Object System.Drawing.PointF ($cx - 40 * $scale), ($top + $h * 0.64)),
    (New-Object System.Drawing.PointF ($cx + 165 * $scale), ($top + $h * 0.36)))
  $g.DrawLines($pen, $pts)
}

function New-Canvas {
  $bmp = New-Object System.Drawing.Bitmap 1024, 1024
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = 'AntiAlias'; $g.PixelOffsetMode = 'HighQuality'
  return @($bmp, $g)
}

# Full icon: teal gradient square (platforms apply their own corner mask).
$bmp, $g = New-Canvas
$rect = New-Object System.Drawing.Rectangle 0, 0, 1024, 1024
$grad = New-Object System.Drawing.Drawing2D.LinearGradientBrush $rect,
  ([System.Drawing.Color]::FromArgb(255, 20, 140, 136)),
  ([System.Drawing.Color]::FromArgb(255, 10, 82, 84)), 90
$g.FillRectangle($grad, $rect)
Draw-Mark $g 1.0
$bmp.Save((Join-Path $out 'icon.png'), [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $bmp.Dispose()

# Adaptive-icon foreground: transparent, mark inside the 66% safe zone.
$bmp, $g = New-Canvas
$g.Clear([System.Drawing.Color]::Transparent)
Draw-Mark $g 0.62
$bmp.Save((Join-Path $out 'icon_foreground.png'), [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $bmp.Dispose()
"wrote $out"
