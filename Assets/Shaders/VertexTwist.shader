Shader "MyCustom/VertexTwist" {
    Properties {
        _Speed ("Speed", Float) = 1.0
        _Twistiness ("Twistiness", Float) = 1.0
        _MainTex ("Texture", 2D) = "white" {}
    }
	
    SubShader {
        Pass{

            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            uniform float _Speed;
            uniform float _Twistiness;

            struct VertexShaderInput{
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct VertexShaderOutput{
                float4 vertex : SV_POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            VertexShaderOutput vert(VertexShaderInput v) {
                VertexShaderOutput o;

                const float PI = 3.14159;
                
                float rad = sin(_Time.y * _Speed);
                
                float useTwist = 10.0;
                
                if (_Twistiness >= 10.0) {
                    useTwist = 0.01;
                } else if (_Twistiness <= 0.0) {
                    useTwist = 10;    
                } else {
                    useTwist = 10 - _Twistiness;
                }
                
                float ct = cos(v.vertex.y/useTwist);
                float st = sin(v.vertex.y/useTwist);
               
                float newx = v.vertex.x + (v.vertex.x * ct * rad - v.vertex.z * st * rad ); 
                float newz = v.vertex.z + (v.vertex.x * st * rad + v.vertex.z * ct * rad ); 
                float newy = v.vertex.y ;
                
                float4 xyz = float4(newx, newy, newz, 1.0);
                
                o.vertex = UnityObjectToClipPos(xyz);
                o.normal = v.normal;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                
                return o;
            }

            fixed4 frag (VertexShaderOutput i) : SV_Target {
                fixed4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            
            ENDCG
        }
    }
    FallBack "Diffuse"
}
