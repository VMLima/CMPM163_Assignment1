Shader "MyCustom/ImageProcessing" {
    Properties {
        _MainTex ("Main Tex", 2D) = "white" {}
        _BlurSteps ("BlurSteps", Float) = 3
        _Mix ("Mix", Float) = 0
        _LookUpDistance ("LookUpDistance", Int) = 1
    }
	
    SubShader {
       Pass {
            CGPROGRAM
        
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            
            uniform float4 _MainTex_TexelSize; //special value
            uniform float _BlurSteps;
            uniform float _Mix;
            uniform float _LookUpDistance;
            
            struct vertexShaderInput {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct vertexShaderOutput {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            vertexShaderOutput vert (vertexShaderInput v) {
                vertexShaderOutput o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;

            fixed4 frag (vertexShaderOutput i) : SV_Target {

                float2 texel = float2(
                    _MainTex_TexelSize.x * _LookUpDistance, 
                    _MainTex_TexelSize.y * _LookUpDistance
                );
        
                // Blur shader
                float3 avg = 0.0;
        
                int steps = ((int)_BlurSteps) * 2 + 1;

                if (steps < 0) {
                    avg = tex2D( _MainTex, i.uv).rgb;
                } else {
        
                    int x, y;
        
                    for ( x = -steps * 0.5; x <=steps * 0.5 ; x++) {
                        for (int y = -steps * 0.5; y <= steps * 0.5; y++) {
                            avg += tex2D( _MainTex, i.uv + texel * float2( x, y ) ).rgb;
                        }
                    }
        
                    avg /= steps * steps;
                }
                
                // Edge shader
                float3x3 Gx = float3x3( -1, -2, -1, 0, 0, 0, 1, 2, 1 ); // x direction kernel
                float3x3 Gy = float3x3( -1, 0, 1, -2, 0, 2, -1, 0, 1 ); // y direction kernel

        
                // fetch the 3x3 neighborhood of a fragment
                float tx0y0 = tex2D( _MainTex, i.uv + texel * float2( -1, -1 ) ).r;
                float tx0y1 = tex2D( _MainTex, i.uv + texel * float2( -1,  0 ) ).r;
                float tx0y2 = tex2D( _MainTex, i.uv + texel * float2( -1,  1 ) ).r;

                float tx1y0 = tex2D( _MainTex, i.uv + texel * float2(  0, -1 ) ).r;
                float tx1y1 = tex2D( _MainTex, i.uv + texel * float2(  0,  0 ) ).r;
                float tx1y2 = tex2D( _MainTex, i.uv + texel * float2(  0,  1 ) ).r;

                float tx2y0 = tex2D( _MainTex, i.uv + texel * float2(  1, -1 ) ).r;
                float tx2y1 = tex2D( _MainTex, i.uv + texel * float2(  1,  0 ) ).r;
                float tx2y2 = tex2D( _MainTex, i.uv + texel * float2(  1,  1 ) ).r;

                float valueGx = Gx[0][0] * tx0y0 + Gx[1][0] * tx1y0 + Gx[2][0] * tx2y0 + 
                        Gx[0][1] * tx0y1 + Gx[1][1] * tx1y1 + Gx[2][1] * tx2y1 + 
                        Gx[0][2] * tx0y2 + Gx[1][2] * tx1y2 + Gx[2][2] * tx2y2;

                float valueGy = Gy[0][0] * tx0y0 + Gy[1][0] * tx1y0 + Gy[2][0] * tx2y0 + 
                        Gy[0][1] * tx0y1 + Gy[1][1] * tx1y1 + Gy[2][1] * tx2y1 + 
                        Gy[0][2] * tx0y2 + Gy[1][2] * tx1y2 + Gy[2][2] * tx2y2;

                float G = sqrt( ( valueGx * valueGx ) + ( valueGy * valueGy ) );
        
                float4 edgePix = float4( float3( G,G,G ), 1.0);
                float4 texPix = tex2D(_MainTex, i.uv);
        
                float4 edgeCol = lerp(texPix, edgePix, _Mix); 
        
                // Return the blur shader multiplied by the edge sahder
                return float4(avg, 1.0) * edgeCol;
            }

            ENDCG
        }

    }
    //FallBack "Diffuse"
}
