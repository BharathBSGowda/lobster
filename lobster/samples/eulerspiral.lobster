// simple graphics demo showing euler spirals:
// http://blog.matthen.com/post/67889183164/draw-a-straight-line-and-then-continue-it-for-the

include "vec.lobster"
include "color.lobster"
include "uihelpers.lobster"

fatal(gl_window("euler spiral", 1024, 768))

pts := [ xy_0, xy_x ]
angle := 0.0

szv := scrollzoomview {
    rate: 1.3,
    mins: 5,
    default: 10,
    maxs: 22,
    buttonname: "mouse1"
}

while gl_frame():
    if gl_button("escape") == 1: return
    gl_clear(color_black)
    scale, panoffset := szv.update(xy_1 * -50, xy_1 * 50, gl_windowsize())
    gl_scale(scale)
    gl_translate(panoffset)
    if pts.length < 10000:
        angle += 2.0 + (rndfloat() - 0.5) / 20.0
        a := atan2(pts.top - pts[pts.length - 2])
        pts.push(pts.top + sincos(a + angle))
    gl_linemode 1:
        gl_polygon(pts)
