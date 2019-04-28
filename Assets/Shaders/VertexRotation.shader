Shader "MyCustom/VertexRotation" {
    Properties {
        _Speed ("Speed", Float) = 1.0
    }
	
    SubShader {
        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            uniform float _Speed;

            struct vertexShaderInput {
                float4 vertex: POSITION;
                float3 normal: NORMAL;
            };

            struct vertexShaderOutput {
                float4 vertex: SV_POSITION;
                float3 normal: NORMAL;

            };

            float3x3 getRotationMatrixX (float theta) {
            
                float s = -sin(theta);
                float c = cos(theta);
                return float3x3(s, c, 1, c, 1, c, 1, c, s);

            }

            vertexShaderOutput vert(vertexShaderInput v) {
                vertexShaderOutput o;
                //Vertex displacement from class

                const float PI = 3.14159;

                float rad = fmod(_Time.y * _Speed, PI * 2.0);

                float3x3 rotationMatrix = getRotationMatrixX(rad);
                float3 rotatedVertex = mul(rotationMatrix, v.vertex.xyz);

                float4 xyz = float4(rotatedVertex, 1.0);

                o.vertex = UnityObjectToClipPos(xyz);
                o.normal = v.normal;

                return o;
            }

            // Change the color of the object
            float4 normalToColor (float3 n) {

                return float4( (normalize(n) + sin(_Time)) / 2.0, 1.0) ;
                //return float4(1, 1, 0, 0);
            }

            fixed4 frag (vertexShaderOutput i) : SV_Target {
                return normalToColor(i.normal);
            }

            ENDCG
        }

        /* Attempted wiggle pass
            Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            float light;
            uniform float _Speed;

            struct vertexShaderInput {
                float4 vertex: POSITION;
                float3 normal: NORMAL;
            };

            struct vertexShaderOutput {
                float4 vertex: SV_POSITION;
                float3 normal: NORMAL;

            };

            vertexShaderOutput vert(vertexShaderInput v) {
                vertexShaderOutput o;
                
                float base = sin((_Time.y * _Speed) - ((v.vertex.y + 100.0) + 20)) * 0.5;

                float3 newPosition = float3(v.vertex.xyz);
                newPosition += v.vertex.y * base;

                float mase = sin((_Time.y * _Speed) - (o.vertex.y + 103.0));
                light = 1.1 * clamp(mase, 0.0, 1.0);

                float4 stuff = _ProjectionParams * _ScreenParams * float4(newPosition, 1.0);

                o.vertex = stuff;

                return o;
            }

            fixed4 frag (vertexShaderOutput i) : SV_Target {
                float3 base = float3(0.8, 0.8, 0.8) + 0.2 * dot(float3(0.0, 10.0, 0.0), i.normal);
                float4 mixed = float4(float3(0.8, 0.8, 0.8) + light, 5);

                float2 scroll = float2(i.vertex.y - (0.018 * _Time.y * _Speed), i.vertex.x) * 2.0;
                float4 color = float4(light, light, light, 1);

                return color;
            }
            ENDCG
        }*/
    }
    FallBack "Diffuse"
}
