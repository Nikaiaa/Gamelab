shader_type canvas_item;

uniform bool active = false;
uniform float aspect;
uniform float distortion = 1.0;
uniform float radius = 1.0;
uniform float alpha = 1.0;
uniform float crop = 1.0;
uniform vec4 crop_color : source_color = vec4(0,0,0,1);
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float crop_feathering = 0.1;

const float base_distortion = 0.99; 
uniform float channel_offset : hint_range(-0.1, 0.1, 0.001) = 0.01; 
uniform float noise_strength = 0.5;

vec2 distort(vec2 p)
{
    float d = length(p);
    float z = sqrt(distortion + d * d * -distortion);
    float r = atan(d, z) / 3.1415926535;
    float phi = atan(p.y, p.x);
    return vec2(r * cos(phi) * (1.0 / aspect) + 0.5, r * sin(phi) + 0.5);
}

void fragment()
{
    if (active) {
        vec2 xy = (SCREEN_UV * 2.0 - 1.0); 
        xy = vec2(xy.x * aspect, xy.y); 
        float d = length(xy);
        vec4 tex;
        if (d < radius)
        {
            vec2 distorted_uv_r = distort(xy * (base_distortion + 0.0 * channel_offset)); 
            vec2 distorted_uv_g = distort(xy * (base_distortion + 1.0 * channel_offset)); 
            vec2 distorted_uv_b = distort(xy * (base_distortion + 2.0 * channel_offset)); 
            
            tex.r = texture(SCREEN_TEXTURE, distorted_uv_r).r;
            tex.g = texture(SCREEN_TEXTURE, distorted_uv_g).g;
            tex.b = texture(SCREEN_TEXTURE, distorted_uv_b).b;
            
            float x = (UV.x + 4.0 ) * (UV.y + 4.0 ) * (TIME * 10.0);
            tex = tex + vec4(mod((mod(x, 13.0) ) * (mod(x, 123.0) ), 0.01)-0.005) * noise_strength;
            COLOR = tex;
            COLOR.a = alpha;
        }

        if (d > crop)
        {
            float softness = smoothstep(crop, crop + crop_feathering, d);
            COLOR = mix(tex, crop_color, softness);
            COLOR.a = alpha;
        }
    } else {
        // Si le shader n'est pas actif, utilisez simplement la couleur d'arrière-plan
        COLOR = vec4(0.0, 0.0, 0.0, 0.0);
    }
}