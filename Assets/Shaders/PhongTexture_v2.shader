Shader "MyCustom/PhongTexture_v2" {
    Properties {
        _Color ("Color", Color) = (0,1,0,1)
        _SpecularColor ("Specular Color", Color) = (1, 1, 1, 1)
        _Shininess("Shininess", Float) = 1.0
        _MainTex ("Main Tex", 2D) = "white" {}
        
    }

    SubShader {
        Pass {
            Tags{"LightMode" = "ForwardBase"}
            //Blend One One

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            float4 _LightColor0;
            float4 _Color;
            float4 _SpecularColor;
            float _Shininess;
            sampler2D _MainTex;
            
            struct vertexShaderInput {
                float4 position: POSITION;
                float3 normal: NORMAL; 
                float2 uv: TEXCOORD0;
            };
            
            struct vertexShaderOutput {
                float4 position: SV_POSITION;
                float3 normal: NORMAL;
                float3 vertInWorldCoords: TEXCOORD1;
                float2 uv: TEXCOORD0;
            };
            
            vertexShaderOutput vert(vertexShaderInput v) {
                vertexShaderOutput o;

                o.vertInWorldCoords = mul(unity_ObjectToWorld, v.position);
                o.position = UnityObjectToClipPos(v.position);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.uv = v.uv;
                return o;
            }
            
            float4 frag(vertexShaderOutput i):SV_Target {
                float3 P = i.vertInWorldCoords.xyz;
                float3 N = normalize(i.normal);
                float3 V = normalize(_WorldSpaceCameraPos - P);
                float3 L = normalize(_WorldSpaceLightPos0.xyz - P);
                float3 H = normalize(L + V);
                
                float3 Kd = _Color.rgb;
				float3 Ka = float3(1, 1, 1);
				float3 Ks = _SpecularColor.rgb; //Color of specular highlighting
                float3 Kl = _LightColor0.rgb; //Color of light
				float3 ambient = Ka * float3(0.1, 0.1, 0.1);
				float diffuseVal = Kd * Kl * max(dot(N, L), 0);
				float3 diffuse = Kd * Kl * diffuseVal;
				float specularVal = Ks * Kl * pow(max(dot(N, H), 0), _Shininess);

				if (diffuseVal <= 0) {
                    specularVal = 0;
                }
                
                float3 specular = Ks * Kl * specularVal;

				//fixed4 col = tex2D(_MainTex, i.uv);
                
                //FINAL COLOR OF FRAGMENT
                return float4(ambient + diffuse + specular, 1.0) * tex2D(_MainTex, i.uv);

                
            }
            
            ENDCG
        }

         Pass {
            Tags{"LightMode" = "ForwardAdd"}
            Blend One One

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            float4 _LightColor0;
            float4 _Color;
            float4 _SpecularColor;
            float _Shininess;
            sampler2D _MainTex;
            
            struct vertexShaderInput {
                float4 position: POSITION;
                float3 normal: NORMAL; 
                float2 uv: TEXCOORD0;
            };
            
            struct vertexShaderOutput {
                float4 position: SV_POSITION;
                float3 normal: NORMAL;
                float3 vertInWorldCoords: TEXCOORD1;
                float2 uv: TEXCOORD0;
            };

            
            vertexShaderOutput vert(vertexShaderInput v) {
                vertexShaderOutput o;

                o.vertInWorldCoords = mul(unity_ObjectToWorld, v.position);
                o.position = UnityObjectToClipPos(v.position);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.uv = v.uv;
                return o;
            }
            
            float4 frag(vertexShaderOutput i):SV_Target {
                float3 P = i.vertInWorldCoords.xyz;
                float3 N = normalize(i.normal);
                float3 V = normalize(_WorldSpaceCameraPos - P);
                float3 L = normalize(_WorldSpaceLightPos0.xyz - P);
                float3 H = normalize(L + V);
                
                float3 Kd = _Color.rgb;
				float3 Ka = float3(1, 1, 1);
				float3 Ks = _SpecularColor.rgb; //Color of specular highlighting
                float3 Kl = _LightColor0.rgb; //Color of light
				float3 ambient = Ka * float3(0.1, 0.1, 0.1);
				float diffuseVal = Kd * Kl * max(dot(N, L), 0);
				float3 diffuse = Kd * Kl * diffuseVal;
				float specularVal = Ks * Kl * pow(max(dot(N, H), 0), _Shininess);

				if (diffuseVal <= 0) {
                    specularVal = 0;
                }
                
                float3 specular = Ks * Kl * specularVal;

				//fixed4 col = tex2D(_MainTex, i.uv);
                
                //FINAL COLOR OF FRAGMENT
                return float4(ambient + diffuse + specular, 1.0) * tex2D(_MainTex, i.uv);

                
            }
            
            ENDCG
        }

        Pass {
            Tags{"LightMode" = "ForwardAdd"}
            Blend One One

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            float4 _LightColor0;
            float4 _Color;
            float4 _SpecularColor;
            float _Shininess;
            sampler2D _MainTex;
            
            struct vertexShaderInput {
                float4 position: POSITION;
                float3 normal: NORMAL; 
                float2 uv: TEXCOORD0;
            };
            
            struct vertexShaderOutput {
                float4 position: SV_POSITION;
                float3 normal: NORMAL;
                float3 vertInWorldCoords: TEXCOORD1;
                float2 uv: TEXCOORD0;
            };

            
            vertexShaderOutput vert(vertexShaderInput v) {
                vertexShaderOutput o;

                o.vertInWorldCoords = mul(unity_ObjectToWorld, v.position);
                o.position = UnityObjectToClipPos(v.position);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.uv = v.uv;
                return o;
            }
            
            float4 frag(vertexShaderOutput i):SV_Target {
                float3 P = i.vertInWorldCoords.xyz;
                float3 N = normalize(i.normal);
                float3 V = normalize(_WorldSpaceCameraPos - P);
                float3 L = normalize(_WorldSpaceLightPos0.xyz - P);
                float3 H = normalize(L + V);
                
                float3 Kd = _Color.rgb;
				float3 Ka = float3(1, 1, 1);
				float3 Ks = _SpecularColor.rgb; //Color of specular highlighting
                float3 Kl = _LightColor0.rgb; //Color of light
				float3 ambient = Ka * float3(0.1, 0.1, 0.1);
				float diffuseVal = Kd * Kl * max(dot(N, L), 0);
				float3 diffuse = Kd * Kl * diffuseVal;
				float specularVal = Ks * Kl * pow(max(dot(N, H), 0), _Shininess);

				if (diffuseVal <= 0) {
                    specularVal = 0;
                }
                
                float3 specular = Ks * Kl * specularVal;

				//fixed4 col = tex2D(_MainTex, i.uv);
                
                //FINAL COLOR OF FRAGMENT
                return float4(ambient + diffuse + specular, 1.0) * tex2D(_MainTex, i.uv);

                
            }
            
            ENDCG
        }

    }
    //FallBack "Diffuse"
}

