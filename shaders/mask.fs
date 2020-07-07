extern Image alpha;
vec4 effect(vec4 color, Image texture, vec2 tc, vec2 sc) {
  float a = Texel(alpha, tc).a;
  vec4 c = Texel(texture, tc);
  return vec4(c.r, c.g, c.b, c.a * a);
}