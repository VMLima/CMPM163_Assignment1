// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/MoltenCore"
{

	Properties{
		_iChannel0 ("iChannel0", 2D) = "white" {}
	}

    SubShader {
    
        Pass {


            CGPROGRAM

			#define iChannel0 _iChannel0
            sampler2D iChannel0;
			//Texture2D iChannel0;

			#define iTime _Time.y

			#define  pi (3.141592653589793238462)
			#define  EPSILON (0.0001)

			//sampler2D _MainTex
			
            #pragma vertex vert
            #pragma fragment frag

			struct appdata{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};
            
            struct v2f{
				float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };
            
            v2f vert(appdata v) {
                v2f o;
                o.vertex = UnityObjectToClipPos (v.vertex);
				o.uv = v.uv;
				
                return o;
            }

			float2 rotate(float2 v, float a){
				float c = cos(a);
				float s = sin(a);
				return float2(
					v.x*c-v.y*s,
					v.x*s+v.y*c
				);
			}

			float sphere(float3 p, float r){
				return length(p) - r;
			}

			float scene(float3 p){
				float b = sphere(p, 1.6);
				if (b > 0.001) return b;
				float3 disp = float3(0, 0, 0);
				float f = 0.5f;
				disp.x = tex2D(iChannel0, p.zy * 0.05 + iTime * 0.02).x * f;
				disp.z = tex2D(iChannel0, p.xy * 0.05 + iTime * 0.03).z * f;
				disp.y = tex2D(iChannel0, p.xz * 0.05 + iTime * 0.04).y * f;

				return sphere(p + disp, 1.0 + sin(iTime*2.4) * 0.15);
			}

            float4 frag(v2f i) : SV_Target {
				//float4 mainImage(float2 fragCoord : SV_POSITION) : SV_Target {
				float2 uv = float2(i.vertex.x / _ScreenParams.x, i.vertex.y / _ScreenParams.y);
				uv -= 0.5;
				uv /= float2(_ScreenParams.y / _ScreenParams.x, 1);

				float3 cam = float3(0, -0.15, -3.5);
				float3 dir = normalize(float3(uv,1));

				float cam_a2 = sin(iTime) * pi * 0.1;
				cam.yz = rotate(cam.yz, cam_a2);
				dir.yz = rotate(dir.yz, cam_a2);

				float cam_a = iTime * pi * 0.1;
				cam.xz = rotate(cam.xz, cam_a);
				dir.xz = rotate(dir.xz, cam_a);

				float4 color = float4(0.16, 0.12, 0.10, 1);
				float t = 0.00001;
				const int maxSteps = 128;
				[unroll(100)]
				for(int i = 0; i < maxSteps; ++i) {
					float3 p = cam + dir * t;
					float d = scene(p);

					if(d < 0.0001 * t) {
						color = float4(1.0, length(p) * (0.6 + (sin(iTime*3.0)+1.0) * 0.5 * 0.4), 0, 1);
						break;
					}

					t += d;

				}

				//fragColor.rgb = color;
				//fragColor.a = 1.0;
				return color;
                
            }

            ENDCG
        }
    }
}
