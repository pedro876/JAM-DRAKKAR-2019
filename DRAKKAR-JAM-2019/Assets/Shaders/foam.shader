// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32853,y:32925,varname:node_3138,prsc:2|emission-7241-RGB,voffset-8572-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32251,y:32602,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.858179,c2:0.875089,c3:0.8962264,c4:1;n:type:ShaderForge.SFN_ArcCos,id:5815,x:32510,y:32732,varname:node_5815,prsc:2|IN-5565-OUT;n:type:ShaderForge.SFN_TexCoord,id:4780,x:31599,y:32779,varname:node_4780,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Length,id:5565,x:32233,y:32846,varname:node_5565,prsc:2|IN-8423-OUT;n:type:ShaderForge.SFN_Time,id:3050,x:31969,y:33100,varname:node_3050,prsc:2;n:type:ShaderForge.SFN_Multiply,id:9343,x:32399,y:33057,varname:node_9343,prsc:2|A-2675-OUT,B-3050-TTR;n:type:ShaderForge.SFN_RemapRange,id:8423,x:31854,y:32881,varname:node_8423,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-4780-UVOUT;n:type:ShaderForge.SFN_Sin,id:8572,x:32602,y:33039,varname:node_8572,prsc:2|IN-9343-OUT;n:type:ShaderForge.SFN_ValueProperty,id:696,x:32331,y:33334,ptovrint:False,ptlb:Randomize,ptin:_Randomize,varname:node_696,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:4;n:type:ShaderForge.SFN_ArcTan2,id:6021,x:32056,y:32740,varname:node_6021,prsc:2,attp:0|A-4780-U,B-4780-V;n:type:ShaderForge.SFN_Posterize,id:2675,x:32292,y:33009,varname:node_2675,prsc:2|IN-5565-OUT,STPS-696-OUT;proporder:7241-696;pass:END;sub:END;*/

Shader "Shader Forge/foam" {
    Properties {
        _Color ("Color", Color) = (0.858179,0.875089,0.8962264,1)
        _Randomize ("Randomize", Float ) = 4
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _Color;
            uniform float _Randomize;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                float node_5565 = length((o.uv0*2.0+-1.0));
                float4 node_3050 = _Time;
                float node_8572 = sin((floor(node_5565 * _Randomize) / (_Randomize - 1)*node_3050.a));
                v.vertex.xyz += float3(node_8572,node_8572,node_8572);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float3 emissive = _Color.rgb;
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Back
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float _Randomize;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                float node_5565 = length((o.uv0*2.0+-1.0));
                float4 node_3050 = _Time;
                float node_8572 = sin((floor(node_5565 * _Randomize) / (_Randomize - 1)*node_3050.a));
                v.vertex.xyz += float3(node_8572,node_8572,node_8572);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
