// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32853,y:32925,varname:node_3138,prsc:2|emission-7241-RGB,custl-4865-X,voffset-8572-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32251,y:32602,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.858179,c2:0.875089,c3:0.8962264,c4:1;n:type:ShaderForge.SFN_ArcCos,id:5815,x:32421,y:32913,varname:node_5815,prsc:2|IN-5565-OUT;n:type:ShaderForge.SFN_TexCoord,id:4780,x:31765,y:32809,varname:node_4780,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Length,id:5565,x:32213,y:32913,varname:node_5565,prsc:2|IN-8423-OUT;n:type:ShaderForge.SFN_Time,id:3050,x:31969,y:33100,varname:node_3050,prsc:2;n:type:ShaderForge.SFN_Multiply,id:9343,x:32399,y:33057,varname:node_9343,prsc:2|A-8423-OUT,B-3050-TTR,C-4865-X;n:type:ShaderForge.SFN_RemapRange,id:8423,x:32027,y:32913,varname:node_8423,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-4780-UVOUT;n:type:ShaderForge.SFN_Sin,id:8572,x:32602,y:33039,varname:node_8572,prsc:2|IN-9343-OUT;n:type:ShaderForge.SFN_ValueProperty,id:696,x:32331,y:33334,ptovrint:False,ptlb:Randomize,ptin:_Randomize,varname:node_696,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:4;n:type:ShaderForge.SFN_FragmentPosition,id:4865,x:32133,y:33250,varname:node_4865,prsc:2;proporder:7241-696;pass:END;sub:END;*/

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
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                float2 node_8423 = (o.uv0*2.0+-1.0);
                float4 node_3050 = _Time;
                v.vertex.xyz += float3(sin((node_8423*node_3050.a*mul(unity_ObjectToWorld, v.vertex).r)),0.0);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float3 emissive = _Color.rgb;
                float3 finalColor = emissive + float3(i.posWorld.r,i.posWorld.r,i.posWorld.r);
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
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                float2 node_8423 = (o.uv0*2.0+-1.0);
                float4 node_3050 = _Time;
                v.vertex.xyz += float3(sin((node_8423*node_3050.a*mul(unity_ObjectToWorld, v.vertex).r)),0.0);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
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
