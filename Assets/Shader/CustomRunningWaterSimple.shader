Shader "Custom/RunningWaterSimple" {
	Properties {
		_Color ("Main Color", Vector) = (1,1,1,1)
		_Transparency ("Transparency", Range(-0.5, 0.5)) = 0.1
		_WaveSpeed ("wave velocity", Range(-10, 10)) = 1
		_SplashTex ("Splash Texture", 2D) = "Black" {}
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			GpuProgramID 62645
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_WorldToObject[0].xyz;
					  tmpvar_4[1] = unity_WorldToObject[1].xyz;
					  tmpvar_4[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
					  worldNormal_1 = tmpvar_5;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 lightDir_4;
					  mediump vec3 tmpvar_5;
					  tmpvar_5 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_5;
					  tmpvar_3 = xlv_TEXCOORD1;
					  lowp float tmpvar_6;
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_8;
					  tmpvar_8 = (_Time.x * _WaveSpeed);
					  tmpvar_7.y = (xlv_TEXCOORD0.y + tmpvar_8);
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + (tmpvar_8 * 0.5));
					  tmpvar_6 = (_Transparency + 0.5);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_4;
					  lowp vec4 c_10;
					  lowp vec4 c_11;
					  lowp float diff_12;
					  mediump float tmpvar_13;
					  tmpvar_13 = max (0.0, dot (tmpvar_3, tmpvar_2));
					  diff_12 = tmpvar_13;
					  c_11.xyz = (((texture2D (_SplashTex, tmpvar_7) + texture2D (_SplashTex, tmpvar_9)).xyz * tmpvar_1) * diff_12);
					  c_11.w = tmpvar_6;
					  c_10.w = c_11.w;
					  c_10.xyz = c_11.xyz;
					  gl_FragData[0] = c_10;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_WorldToObject[0].xyz;
					  tmpvar_4[1] = unity_WorldToObject[1].xyz;
					  tmpvar_4[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
					  worldNormal_1 = tmpvar_5;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 lightDir_4;
					  mediump vec3 tmpvar_5;
					  tmpvar_5 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_5;
					  tmpvar_3 = xlv_TEXCOORD1;
					  lowp float tmpvar_6;
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_8;
					  tmpvar_8 = (_Time.x * _WaveSpeed);
					  tmpvar_7.y = (xlv_TEXCOORD0.y + tmpvar_8);
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + (tmpvar_8 * 0.5));
					  tmpvar_6 = (_Transparency + 0.5);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_4;
					  lowp vec4 c_10;
					  lowp vec4 c_11;
					  lowp float diff_12;
					  mediump float tmpvar_13;
					  tmpvar_13 = max (0.0, dot (tmpvar_3, tmpvar_2));
					  diff_12 = tmpvar_13;
					  c_11.xyz = (((texture2D (_SplashTex, tmpvar_7) + texture2D (_SplashTex, tmpvar_9)).xyz * tmpvar_1) * diff_12);
					  c_11.w = tmpvar_6;
					  c_10.w = c_11.w;
					  c_10.xyz = c_11.xyz;
					  gl_FragData[0] = c_10;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_WorldToObject[0].xyz;
					  tmpvar_4[1] = unity_WorldToObject[1].xyz;
					  tmpvar_4[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
					  worldNormal_1 = tmpvar_5;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 lightDir_4;
					  mediump vec3 tmpvar_5;
					  tmpvar_5 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_5;
					  tmpvar_3 = xlv_TEXCOORD1;
					  lowp float tmpvar_6;
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_8;
					  tmpvar_8 = (_Time.x * _WaveSpeed);
					  tmpvar_7.y = (xlv_TEXCOORD0.y + tmpvar_8);
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + (tmpvar_8 * 0.5));
					  tmpvar_6 = (_Transparency + 0.5);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_4;
					  lowp vec4 c_10;
					  lowp vec4 c_11;
					  lowp float diff_12;
					  mediump float tmpvar_13;
					  tmpvar_13 = max (0.0, dot (tmpvar_3, tmpvar_2));
					  diff_12 = tmpvar_13;
					  c_11.xyz = (((texture2D (_SplashTex, tmpvar_7) + texture2D (_SplashTex, tmpvar_9)).xyz * tmpvar_1) * diff_12);
					  c_11.w = tmpvar_6;
					  c_10.w = c_11.w;
					  c_10.xyz = c_11.xyz;
					  gl_FragData[0] = c_10;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_WorldToObject[0].xyz;
					  tmpvar_4[1] = unity_WorldToObject[1].xyz;
					  tmpvar_4[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
					  worldNormal_1 = tmpvar_5;
					  tmpvar_2 = worldNormal_1;
					  mediump vec3 normal_6;
					  normal_6 = worldNormal_1;
					  mediump vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = normal_6;
					  mediump vec3 res_8;
					  mediump vec3 x_9;
					  x_9.x = dot (unity_SHAr, tmpvar_7);
					  x_9.y = dot (unity_SHAg, tmpvar_7);
					  x_9.z = dot (unity_SHAb, tmpvar_7);
					  mediump vec3 x1_10;
					  mediump vec4 tmpvar_11;
					  tmpvar_11 = (normal_6.xyzz * normal_6.yzzx);
					  x1_10.x = dot (unity_SHBr, tmpvar_11);
					  x1_10.y = dot (unity_SHBg, tmpvar_11);
					  x1_10.z = dot (unity_SHBb, tmpvar_11);
					  res_8 = (x_9 + (x1_10 + (unity_SHC.xyz * 
					    ((normal_6.x * normal_6.x) - (normal_6.y * normal_6.y))
					  )));
					  mediump vec3 tmpvar_12;
					  tmpvar_12 = max (((1.055 * 
					    pow (max (res_8, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_8 = tmpvar_12;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_12);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp float tmpvar_7;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_9;
					  tmpvar_9 = (_Time.x * _WaveSpeed);
					  tmpvar_8.y = (xlv_TEXCOORD0.y + tmpvar_9);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + (tmpvar_9 * 0.5));
					  tmpvar_7 = (_Transparency + 0.5);
					  tmpvar_3 = (texture2D (_SplashTex, tmpvar_8) + texture2D (_SplashTex, tmpvar_10)).xyz;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_11;
					  lowp vec4 c_12;
					  lowp float diff_13;
					  mediump float tmpvar_14;
					  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_13 = tmpvar_14;
					  c_12.xyz = ((tmpvar_3 * tmpvar_1) * diff_13);
					  c_12.w = tmpvar_7;
					  c_11.w = c_12.w;
					  c_11.xyz = (c_12.xyz + (tmpvar_3 * xlv_TEXCOORD3));
					  gl_FragData[0] = c_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_WorldToObject[0].xyz;
					  tmpvar_4[1] = unity_WorldToObject[1].xyz;
					  tmpvar_4[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
					  worldNormal_1 = tmpvar_5;
					  tmpvar_2 = worldNormal_1;
					  mediump vec3 normal_6;
					  normal_6 = worldNormal_1;
					  mediump vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = normal_6;
					  mediump vec3 res_8;
					  mediump vec3 x_9;
					  x_9.x = dot (unity_SHAr, tmpvar_7);
					  x_9.y = dot (unity_SHAg, tmpvar_7);
					  x_9.z = dot (unity_SHAb, tmpvar_7);
					  mediump vec3 x1_10;
					  mediump vec4 tmpvar_11;
					  tmpvar_11 = (normal_6.xyzz * normal_6.yzzx);
					  x1_10.x = dot (unity_SHBr, tmpvar_11);
					  x1_10.y = dot (unity_SHBg, tmpvar_11);
					  x1_10.z = dot (unity_SHBb, tmpvar_11);
					  res_8 = (x_9 + (x1_10 + (unity_SHC.xyz * 
					    ((normal_6.x * normal_6.x) - (normal_6.y * normal_6.y))
					  )));
					  mediump vec3 tmpvar_12;
					  tmpvar_12 = max (((1.055 * 
					    pow (max (res_8, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_8 = tmpvar_12;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_12);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp float tmpvar_7;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_9;
					  tmpvar_9 = (_Time.x * _WaveSpeed);
					  tmpvar_8.y = (xlv_TEXCOORD0.y + tmpvar_9);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + (tmpvar_9 * 0.5));
					  tmpvar_7 = (_Transparency + 0.5);
					  tmpvar_3 = (texture2D (_SplashTex, tmpvar_8) + texture2D (_SplashTex, tmpvar_10)).xyz;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_11;
					  lowp vec4 c_12;
					  lowp float diff_13;
					  mediump float tmpvar_14;
					  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_13 = tmpvar_14;
					  c_12.xyz = ((tmpvar_3 * tmpvar_1) * diff_13);
					  c_12.w = tmpvar_7;
					  c_11.w = c_12.w;
					  c_11.xyz = (c_12.xyz + (tmpvar_3 * xlv_TEXCOORD3));
					  gl_FragData[0] = c_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_WorldToObject[0].xyz;
					  tmpvar_4[1] = unity_WorldToObject[1].xyz;
					  tmpvar_4[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
					  worldNormal_1 = tmpvar_5;
					  tmpvar_2 = worldNormal_1;
					  mediump vec3 normal_6;
					  normal_6 = worldNormal_1;
					  mediump vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = normal_6;
					  mediump vec3 res_8;
					  mediump vec3 x_9;
					  x_9.x = dot (unity_SHAr, tmpvar_7);
					  x_9.y = dot (unity_SHAg, tmpvar_7);
					  x_9.z = dot (unity_SHAb, tmpvar_7);
					  mediump vec3 x1_10;
					  mediump vec4 tmpvar_11;
					  tmpvar_11 = (normal_6.xyzz * normal_6.yzzx);
					  x1_10.x = dot (unity_SHBr, tmpvar_11);
					  x1_10.y = dot (unity_SHBg, tmpvar_11);
					  x1_10.z = dot (unity_SHBb, tmpvar_11);
					  res_8 = (x_9 + (x1_10 + (unity_SHC.xyz * 
					    ((normal_6.x * normal_6.x) - (normal_6.y * normal_6.y))
					  )));
					  mediump vec3 tmpvar_12;
					  tmpvar_12 = max (((1.055 * 
					    pow (max (res_8, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_8 = tmpvar_12;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_12);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp float tmpvar_7;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_9;
					  tmpvar_9 = (_Time.x * _WaveSpeed);
					  tmpvar_8.y = (xlv_TEXCOORD0.y + tmpvar_9);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + (tmpvar_9 * 0.5));
					  tmpvar_7 = (_Transparency + 0.5);
					  tmpvar_3 = (texture2D (_SplashTex, tmpvar_8) + texture2D (_SplashTex, tmpvar_10)).xyz;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_11;
					  lowp vec4 c_12;
					  lowp float diff_13;
					  mediump float tmpvar_14;
					  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_13 = tmpvar_14;
					  c_12.xyz = ((tmpvar_3 * tmpvar_1) * diff_13);
					  c_12.w = tmpvar_7;
					  c_11.w = c_12.w;
					  c_11.xyz = (c_12.xyz + (tmpvar_3 * xlv_TEXCOORD3));
					  gl_FragData[0] = c_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp mat3 tmpvar_6;
					  tmpvar_6[0] = unity_WorldToObject[0].xyz;
					  tmpvar_6[1] = unity_WorldToObject[1].xyz;
					  tmpvar_6[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  highp vec3 lightColor0_8;
					  lightColor0_8 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_9;
					  lightColor1_9 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_10;
					  lightColor2_10 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_11;
					  lightColor3_11 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_12;
					  lightAttenSq_12 = unity_4LightAtten0;
					  highp vec3 normal_13;
					  normal_13 = worldNormal_1;
					  highp vec3 col_14;
					  highp vec4 ndotl_15;
					  highp vec4 lengthSq_16;
					  highp vec4 tmpvar_17;
					  tmpvar_17 = (unity_4LightPosX0 - tmpvar_5.x);
					  highp vec4 tmpvar_18;
					  tmpvar_18 = (unity_4LightPosY0 - tmpvar_5.y);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = (unity_4LightPosZ0 - tmpvar_5.z);
					  lengthSq_16 = (tmpvar_17 * tmpvar_17);
					  lengthSq_16 = (lengthSq_16 + (tmpvar_18 * tmpvar_18));
					  lengthSq_16 = (lengthSq_16 + (tmpvar_19 * tmpvar_19));
					  highp vec4 tmpvar_20;
					  tmpvar_20 = max (lengthSq_16, vec4(1e-06, 1e-06, 1e-06, 1e-06));
					  lengthSq_16 = tmpvar_20;
					  ndotl_15 = (tmpvar_17 * normal_13.x);
					  ndotl_15 = (ndotl_15 + (tmpvar_18 * normal_13.y));
					  ndotl_15 = (ndotl_15 + (tmpvar_19 * normal_13.z));
					  highp vec4 tmpvar_21;
					  tmpvar_21 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_15 * inversesqrt(tmpvar_20)));
					  ndotl_15 = tmpvar_21;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = (tmpvar_21 * (1.0/((1.0 + 
					    (tmpvar_20 * lightAttenSq_12)
					  ))));
					  col_14 = (lightColor0_8 * tmpvar_22.x);
					  col_14 = (col_14 + (lightColor1_9 * tmpvar_22.y));
					  col_14 = (col_14 + (lightColor2_10 * tmpvar_22.z));
					  col_14 = (col_14 + (lightColor3_11 * tmpvar_22.w));
					  tmpvar_3 = col_14;
					  mediump vec3 normal_23;
					  normal_23 = worldNormal_1;
					  mediump vec3 ambient_24;
					  mediump vec4 tmpvar_25;
					  tmpvar_25.w = 1.0;
					  tmpvar_25.xyz = normal_23;
					  mediump vec3 res_26;
					  mediump vec3 x_27;
					  x_27.x = dot (unity_SHAr, tmpvar_25);
					  x_27.y = dot (unity_SHAg, tmpvar_25);
					  x_27.z = dot (unity_SHAb, tmpvar_25);
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_23.xyzz * normal_23.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
					    ((normal_23.x * normal_23.x) - (normal_23.y * normal_23.y))
					  )));
					  mediump vec3 tmpvar_30;
					  tmpvar_30 = max (((1.055 * 
					    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_26 = tmpvar_30;
					  ambient_24 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), tmpvar_30));
					  tmpvar_3 = ambient_24;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_5;
					  xlv_TEXCOORD3 = ambient_24;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp float tmpvar_7;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_9;
					  tmpvar_9 = (_Time.x * _WaveSpeed);
					  tmpvar_8.y = (xlv_TEXCOORD0.y + tmpvar_9);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + (tmpvar_9 * 0.5));
					  tmpvar_7 = (_Transparency + 0.5);
					  tmpvar_3 = (texture2D (_SplashTex, tmpvar_8) + texture2D (_SplashTex, tmpvar_10)).xyz;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_11;
					  lowp vec4 c_12;
					  lowp float diff_13;
					  mediump float tmpvar_14;
					  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_13 = tmpvar_14;
					  c_12.xyz = ((tmpvar_3 * tmpvar_1) * diff_13);
					  c_12.w = tmpvar_7;
					  c_11.w = c_12.w;
					  c_11.xyz = (c_12.xyz + (tmpvar_3 * xlv_TEXCOORD3));
					  gl_FragData[0] = c_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp mat3 tmpvar_6;
					  tmpvar_6[0] = unity_WorldToObject[0].xyz;
					  tmpvar_6[1] = unity_WorldToObject[1].xyz;
					  tmpvar_6[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  highp vec3 lightColor0_8;
					  lightColor0_8 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_9;
					  lightColor1_9 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_10;
					  lightColor2_10 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_11;
					  lightColor3_11 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_12;
					  lightAttenSq_12 = unity_4LightAtten0;
					  highp vec3 normal_13;
					  normal_13 = worldNormal_1;
					  highp vec3 col_14;
					  highp vec4 ndotl_15;
					  highp vec4 lengthSq_16;
					  highp vec4 tmpvar_17;
					  tmpvar_17 = (unity_4LightPosX0 - tmpvar_5.x);
					  highp vec4 tmpvar_18;
					  tmpvar_18 = (unity_4LightPosY0 - tmpvar_5.y);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = (unity_4LightPosZ0 - tmpvar_5.z);
					  lengthSq_16 = (tmpvar_17 * tmpvar_17);
					  lengthSq_16 = (lengthSq_16 + (tmpvar_18 * tmpvar_18));
					  lengthSq_16 = (lengthSq_16 + (tmpvar_19 * tmpvar_19));
					  highp vec4 tmpvar_20;
					  tmpvar_20 = max (lengthSq_16, vec4(1e-06, 1e-06, 1e-06, 1e-06));
					  lengthSq_16 = tmpvar_20;
					  ndotl_15 = (tmpvar_17 * normal_13.x);
					  ndotl_15 = (ndotl_15 + (tmpvar_18 * normal_13.y));
					  ndotl_15 = (ndotl_15 + (tmpvar_19 * normal_13.z));
					  highp vec4 tmpvar_21;
					  tmpvar_21 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_15 * inversesqrt(tmpvar_20)));
					  ndotl_15 = tmpvar_21;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = (tmpvar_21 * (1.0/((1.0 + 
					    (tmpvar_20 * lightAttenSq_12)
					  ))));
					  col_14 = (lightColor0_8 * tmpvar_22.x);
					  col_14 = (col_14 + (lightColor1_9 * tmpvar_22.y));
					  col_14 = (col_14 + (lightColor2_10 * tmpvar_22.z));
					  col_14 = (col_14 + (lightColor3_11 * tmpvar_22.w));
					  tmpvar_3 = col_14;
					  mediump vec3 normal_23;
					  normal_23 = worldNormal_1;
					  mediump vec3 ambient_24;
					  mediump vec4 tmpvar_25;
					  tmpvar_25.w = 1.0;
					  tmpvar_25.xyz = normal_23;
					  mediump vec3 res_26;
					  mediump vec3 x_27;
					  x_27.x = dot (unity_SHAr, tmpvar_25);
					  x_27.y = dot (unity_SHAg, tmpvar_25);
					  x_27.z = dot (unity_SHAb, tmpvar_25);
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_23.xyzz * normal_23.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
					    ((normal_23.x * normal_23.x) - (normal_23.y * normal_23.y))
					  )));
					  mediump vec3 tmpvar_30;
					  tmpvar_30 = max (((1.055 * 
					    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_26 = tmpvar_30;
					  ambient_24 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), tmpvar_30));
					  tmpvar_3 = ambient_24;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_5;
					  xlv_TEXCOORD3 = ambient_24;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp float tmpvar_7;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_9;
					  tmpvar_9 = (_Time.x * _WaveSpeed);
					  tmpvar_8.y = (xlv_TEXCOORD0.y + tmpvar_9);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + (tmpvar_9 * 0.5));
					  tmpvar_7 = (_Transparency + 0.5);
					  tmpvar_3 = (texture2D (_SplashTex, tmpvar_8) + texture2D (_SplashTex, tmpvar_10)).xyz;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_11;
					  lowp vec4 c_12;
					  lowp float diff_13;
					  mediump float tmpvar_14;
					  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_13 = tmpvar_14;
					  c_12.xyz = ((tmpvar_3 * tmpvar_1) * diff_13);
					  c_12.w = tmpvar_7;
					  c_11.w = c_12.w;
					  c_11.xyz = (c_12.xyz + (tmpvar_3 * xlv_TEXCOORD3));
					  gl_FragData[0] = c_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp mat3 tmpvar_6;
					  tmpvar_6[0] = unity_WorldToObject[0].xyz;
					  tmpvar_6[1] = unity_WorldToObject[1].xyz;
					  tmpvar_6[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  highp vec3 lightColor0_8;
					  lightColor0_8 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_9;
					  lightColor1_9 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_10;
					  lightColor2_10 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_11;
					  lightColor3_11 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_12;
					  lightAttenSq_12 = unity_4LightAtten0;
					  highp vec3 normal_13;
					  normal_13 = worldNormal_1;
					  highp vec3 col_14;
					  highp vec4 ndotl_15;
					  highp vec4 lengthSq_16;
					  highp vec4 tmpvar_17;
					  tmpvar_17 = (unity_4LightPosX0 - tmpvar_5.x);
					  highp vec4 tmpvar_18;
					  tmpvar_18 = (unity_4LightPosY0 - tmpvar_5.y);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = (unity_4LightPosZ0 - tmpvar_5.z);
					  lengthSq_16 = (tmpvar_17 * tmpvar_17);
					  lengthSq_16 = (lengthSq_16 + (tmpvar_18 * tmpvar_18));
					  lengthSq_16 = (lengthSq_16 + (tmpvar_19 * tmpvar_19));
					  highp vec4 tmpvar_20;
					  tmpvar_20 = max (lengthSq_16, vec4(1e-06, 1e-06, 1e-06, 1e-06));
					  lengthSq_16 = tmpvar_20;
					  ndotl_15 = (tmpvar_17 * normal_13.x);
					  ndotl_15 = (ndotl_15 + (tmpvar_18 * normal_13.y));
					  ndotl_15 = (ndotl_15 + (tmpvar_19 * normal_13.z));
					  highp vec4 tmpvar_21;
					  tmpvar_21 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_15 * inversesqrt(tmpvar_20)));
					  ndotl_15 = tmpvar_21;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = (tmpvar_21 * (1.0/((1.0 + 
					    (tmpvar_20 * lightAttenSq_12)
					  ))));
					  col_14 = (lightColor0_8 * tmpvar_22.x);
					  col_14 = (col_14 + (lightColor1_9 * tmpvar_22.y));
					  col_14 = (col_14 + (lightColor2_10 * tmpvar_22.z));
					  col_14 = (col_14 + (lightColor3_11 * tmpvar_22.w));
					  tmpvar_3 = col_14;
					  mediump vec3 normal_23;
					  normal_23 = worldNormal_1;
					  mediump vec3 ambient_24;
					  mediump vec4 tmpvar_25;
					  tmpvar_25.w = 1.0;
					  tmpvar_25.xyz = normal_23;
					  mediump vec3 res_26;
					  mediump vec3 x_27;
					  x_27.x = dot (unity_SHAr, tmpvar_25);
					  x_27.y = dot (unity_SHAg, tmpvar_25);
					  x_27.z = dot (unity_SHAb, tmpvar_25);
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_23.xyzz * normal_23.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
					    ((normal_23.x * normal_23.x) - (normal_23.y * normal_23.y))
					  )));
					  mediump vec3 tmpvar_30;
					  tmpvar_30 = max (((1.055 * 
					    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_26 = tmpvar_30;
					  ambient_24 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), tmpvar_30));
					  tmpvar_3 = ambient_24;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_5;
					  xlv_TEXCOORD3 = ambient_24;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp float tmpvar_7;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_9;
					  tmpvar_9 = (_Time.x * _WaveSpeed);
					  tmpvar_8.y = (xlv_TEXCOORD0.y + tmpvar_9);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + (tmpvar_9 * 0.5));
					  tmpvar_7 = (_Transparency + 0.5);
					  tmpvar_3 = (texture2D (_SplashTex, tmpvar_8) + texture2D (_SplashTex, tmpvar_10)).xyz;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_11;
					  lowp vec4 c_12;
					  lowp float diff_13;
					  mediump float tmpvar_14;
					  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_13 = tmpvar_14;
					  c_12.xyz = ((tmpvar_3 * tmpvar_1) * diff_13);
					  c_12.w = tmpvar_7;
					  c_11.w = c_12.w;
					  c_11.xyz = (c_12.xyz + (tmpvar_3 * xlv_TEXCOORD3));
					  gl_FragData[0] = c_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp float tmpvar_7;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_9;
					  tmpvar_9 = (_Time.x * _WaveSpeed);
					  tmpvar_8.y = (xlv_TEXCOORD0.y + tmpvar_9);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + (tmpvar_9 * 0.5));
					  tmpvar_7 = (_Transparency + 0.5);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_11;
					  lowp vec4 c_12;
					  lowp float diff_13;
					  mediump float tmpvar_14;
					  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_13 = tmpvar_14;
					  c_12.xyz = (((texture2D (_SplashTex, tmpvar_8) + texture2D (_SplashTex, tmpvar_10)).xyz * tmpvar_1) * diff_13);
					  c_12.w = tmpvar_7;
					  c_11.w = c_12.w;
					  c_11.xyz = c_12.xyz;
					  c_3.w = c_11.w;
					  highp float tmpvar_15;
					  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = mix (unity_FogColor.xyz, c_12.xyz, vec3(tmpvar_15));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp float tmpvar_7;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_9;
					  tmpvar_9 = (_Time.x * _WaveSpeed);
					  tmpvar_8.y = (xlv_TEXCOORD0.y + tmpvar_9);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + (tmpvar_9 * 0.5));
					  tmpvar_7 = (_Transparency + 0.5);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_11;
					  lowp vec4 c_12;
					  lowp float diff_13;
					  mediump float tmpvar_14;
					  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_13 = tmpvar_14;
					  c_12.xyz = (((texture2D (_SplashTex, tmpvar_8) + texture2D (_SplashTex, tmpvar_10)).xyz * tmpvar_1) * diff_13);
					  c_12.w = tmpvar_7;
					  c_11.w = c_12.w;
					  c_11.xyz = c_12.xyz;
					  c_3.w = c_11.w;
					  highp float tmpvar_15;
					  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = mix (unity_FogColor.xyz, c_12.xyz, vec3(tmpvar_15));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp float tmpvar_7;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_9;
					  tmpvar_9 = (_Time.x * _WaveSpeed);
					  tmpvar_8.y = (xlv_TEXCOORD0.y + tmpvar_9);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + (tmpvar_9 * 0.5));
					  tmpvar_7 = (_Transparency + 0.5);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_11;
					  lowp vec4 c_12;
					  lowp float diff_13;
					  mediump float tmpvar_14;
					  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_13 = tmpvar_14;
					  c_12.xyz = (((texture2D (_SplashTex, tmpvar_8) + texture2D (_SplashTex, tmpvar_10)).xyz * tmpvar_1) * diff_13);
					  c_12.w = tmpvar_7;
					  c_11.w = c_12.w;
					  c_11.xyz = c_12.xyz;
					  c_3.w = c_11.w;
					  highp float tmpvar_15;
					  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = mix (unity_FogColor.xyz, c_12.xyz, vec3(tmpvar_15));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  mediump vec3 normal_7;
					  normal_7 = worldNormal_1;
					  mediump vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = normal_7;
					  mediump vec3 res_9;
					  mediump vec3 x_10;
					  x_10.x = dot (unity_SHAr, tmpvar_8);
					  x_10.y = dot (unity_SHAg, tmpvar_8);
					  x_10.z = dot (unity_SHAb, tmpvar_8);
					  mediump vec3 x1_11;
					  mediump vec4 tmpvar_12;
					  tmpvar_12 = (normal_7.xyzz * normal_7.yzzx);
					  x1_11.x = dot (unity_SHBr, tmpvar_12);
					  x1_11.y = dot (unity_SHBg, tmpvar_12);
					  x1_11.z = dot (unity_SHBb, tmpvar_12);
					  res_9 = (x_10 + (x1_11 + (unity_SHC.xyz * 
					    ((normal_7.x * normal_7.x) - (normal_7.y * normal_7.y))
					  )));
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = max (((1.055 * 
					    pow (max (res_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_9 = tmpvar_13;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_13);
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp float tmpvar_8;
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_10;
					  tmpvar_10 = (_Time.x * _WaveSpeed);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + tmpvar_10);
					  highp vec2 tmpvar_11;
					  tmpvar_11.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_11.y = (xlv_TEXCOORD0.y + (tmpvar_10 * 0.5));
					  tmpvar_8 = (_Transparency + 0.5);
					  tmpvar_4 = (texture2D (_SplashTex, tmpvar_9) + texture2D (_SplashTex, tmpvar_11)).xyz;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  lowp vec4 c_12;
					  lowp vec4 c_13;
					  lowp float diff_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_14 = tmpvar_15;
					  c_13.xyz = ((tmpvar_4 * tmpvar_1) * diff_14);
					  c_13.w = tmpvar_8;
					  c_12.w = c_13.w;
					  c_12.xyz = (c_13.xyz + (tmpvar_4 * xlv_TEXCOORD3));
					  c_3.w = c_12.w;
					  highp float tmpvar_16;
					  tmpvar_16 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = mix (unity_FogColor.xyz, c_12.xyz, vec3(tmpvar_16));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  mediump vec3 normal_7;
					  normal_7 = worldNormal_1;
					  mediump vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = normal_7;
					  mediump vec3 res_9;
					  mediump vec3 x_10;
					  x_10.x = dot (unity_SHAr, tmpvar_8);
					  x_10.y = dot (unity_SHAg, tmpvar_8);
					  x_10.z = dot (unity_SHAb, tmpvar_8);
					  mediump vec3 x1_11;
					  mediump vec4 tmpvar_12;
					  tmpvar_12 = (normal_7.xyzz * normal_7.yzzx);
					  x1_11.x = dot (unity_SHBr, tmpvar_12);
					  x1_11.y = dot (unity_SHBg, tmpvar_12);
					  x1_11.z = dot (unity_SHBb, tmpvar_12);
					  res_9 = (x_10 + (x1_11 + (unity_SHC.xyz * 
					    ((normal_7.x * normal_7.x) - (normal_7.y * normal_7.y))
					  )));
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = max (((1.055 * 
					    pow (max (res_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_9 = tmpvar_13;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_13);
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp float tmpvar_8;
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_10;
					  tmpvar_10 = (_Time.x * _WaveSpeed);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + tmpvar_10);
					  highp vec2 tmpvar_11;
					  tmpvar_11.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_11.y = (xlv_TEXCOORD0.y + (tmpvar_10 * 0.5));
					  tmpvar_8 = (_Transparency + 0.5);
					  tmpvar_4 = (texture2D (_SplashTex, tmpvar_9) + texture2D (_SplashTex, tmpvar_11)).xyz;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  lowp vec4 c_12;
					  lowp vec4 c_13;
					  lowp float diff_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_14 = tmpvar_15;
					  c_13.xyz = ((tmpvar_4 * tmpvar_1) * diff_14);
					  c_13.w = tmpvar_8;
					  c_12.w = c_13.w;
					  c_12.xyz = (c_13.xyz + (tmpvar_4 * xlv_TEXCOORD3));
					  c_3.w = c_12.w;
					  highp float tmpvar_16;
					  tmpvar_16 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = mix (unity_FogColor.xyz, c_12.xyz, vec3(tmpvar_16));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  mediump vec3 normal_7;
					  normal_7 = worldNormal_1;
					  mediump vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = normal_7;
					  mediump vec3 res_9;
					  mediump vec3 x_10;
					  x_10.x = dot (unity_SHAr, tmpvar_8);
					  x_10.y = dot (unity_SHAg, tmpvar_8);
					  x_10.z = dot (unity_SHAb, tmpvar_8);
					  mediump vec3 x1_11;
					  mediump vec4 tmpvar_12;
					  tmpvar_12 = (normal_7.xyzz * normal_7.yzzx);
					  x1_11.x = dot (unity_SHBr, tmpvar_12);
					  x1_11.y = dot (unity_SHBg, tmpvar_12);
					  x1_11.z = dot (unity_SHBb, tmpvar_12);
					  res_9 = (x_10 + (x1_11 + (unity_SHC.xyz * 
					    ((normal_7.x * normal_7.x) - (normal_7.y * normal_7.y))
					  )));
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = max (((1.055 * 
					    pow (max (res_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_9 = tmpvar_13;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_13);
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp float tmpvar_8;
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_10;
					  tmpvar_10 = (_Time.x * _WaveSpeed);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + tmpvar_10);
					  highp vec2 tmpvar_11;
					  tmpvar_11.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_11.y = (xlv_TEXCOORD0.y + (tmpvar_10 * 0.5));
					  tmpvar_8 = (_Transparency + 0.5);
					  tmpvar_4 = (texture2D (_SplashTex, tmpvar_9) + texture2D (_SplashTex, tmpvar_11)).xyz;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  lowp vec4 c_12;
					  lowp vec4 c_13;
					  lowp float diff_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_14 = tmpvar_15;
					  c_13.xyz = ((tmpvar_4 * tmpvar_1) * diff_14);
					  c_13.w = tmpvar_8;
					  c_12.w = c_13.w;
					  c_12.xyz = (c_13.xyz + (tmpvar_4 * xlv_TEXCOORD3));
					  c_3.w = c_12.w;
					  highp float tmpvar_16;
					  tmpvar_16 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = mix (unity_FogColor.xyz, c_12.xyz, vec3(tmpvar_16));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  highp vec3 lightColor0_9;
					  lightColor0_9 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_10;
					  lightColor1_10 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_11;
					  lightColor2_11 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_12;
					  lightColor3_12 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_13;
					  lightAttenSq_13 = unity_4LightAtten0;
					  highp vec3 normal_14;
					  normal_14 = worldNormal_1;
					  highp vec3 col_15;
					  highp vec4 ndotl_16;
					  highp vec4 lengthSq_17;
					  highp vec4 tmpvar_18;
					  tmpvar_18 = (unity_4LightPosX0 - tmpvar_6.x);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = (unity_4LightPosY0 - tmpvar_6.y);
					  highp vec4 tmpvar_20;
					  tmpvar_20 = (unity_4LightPosZ0 - tmpvar_6.z);
					  lengthSq_17 = (tmpvar_18 * tmpvar_18);
					  lengthSq_17 = (lengthSq_17 + (tmpvar_19 * tmpvar_19));
					  lengthSq_17 = (lengthSq_17 + (tmpvar_20 * tmpvar_20));
					  highp vec4 tmpvar_21;
					  tmpvar_21 = max (lengthSq_17, vec4(1e-06, 1e-06, 1e-06, 1e-06));
					  lengthSq_17 = tmpvar_21;
					  ndotl_16 = (tmpvar_18 * normal_14.x);
					  ndotl_16 = (ndotl_16 + (tmpvar_19 * normal_14.y));
					  ndotl_16 = (ndotl_16 + (tmpvar_20 * normal_14.z));
					  highp vec4 tmpvar_22;
					  tmpvar_22 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_16 * inversesqrt(tmpvar_21)));
					  ndotl_16 = tmpvar_22;
					  highp vec4 tmpvar_23;
					  tmpvar_23 = (tmpvar_22 * (1.0/((1.0 + 
					    (tmpvar_21 * lightAttenSq_13)
					  ))));
					  col_15 = (lightColor0_9 * tmpvar_23.x);
					  col_15 = (col_15 + (lightColor1_10 * tmpvar_23.y));
					  col_15 = (col_15 + (lightColor2_11 * tmpvar_23.z));
					  col_15 = (col_15 + (lightColor3_12 * tmpvar_23.w));
					  tmpvar_3 = col_15;
					  mediump vec3 normal_24;
					  normal_24 = worldNormal_1;
					  mediump vec3 ambient_25;
					  mediump vec4 tmpvar_26;
					  tmpvar_26.w = 1.0;
					  tmpvar_26.xyz = normal_24;
					  mediump vec3 res_27;
					  mediump vec3 x_28;
					  x_28.x = dot (unity_SHAr, tmpvar_26);
					  x_28.y = dot (unity_SHAg, tmpvar_26);
					  x_28.z = dot (unity_SHAb, tmpvar_26);
					  mediump vec3 x1_29;
					  mediump vec4 tmpvar_30;
					  tmpvar_30 = (normal_24.xyzz * normal_24.yzzx);
					  x1_29.x = dot (unity_SHBr, tmpvar_30);
					  x1_29.y = dot (unity_SHBg, tmpvar_30);
					  x1_29.z = dot (unity_SHBb, tmpvar_30);
					  res_27 = (x_28 + (x1_29 + (unity_SHC.xyz * 
					    ((normal_24.x * normal_24.x) - (normal_24.y * normal_24.y))
					  )));
					  mediump vec3 tmpvar_31;
					  tmpvar_31 = max (((1.055 * 
					    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_27 = tmpvar_31;
					  ambient_25 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), tmpvar_31));
					  tmpvar_3 = ambient_25;
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_6;
					  xlv_TEXCOORD3 = ambient_25;
					  xlv_TEXCOORD4 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp float tmpvar_8;
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_10;
					  tmpvar_10 = (_Time.x * _WaveSpeed);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + tmpvar_10);
					  highp vec2 tmpvar_11;
					  tmpvar_11.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_11.y = (xlv_TEXCOORD0.y + (tmpvar_10 * 0.5));
					  tmpvar_8 = (_Transparency + 0.5);
					  tmpvar_4 = (texture2D (_SplashTex, tmpvar_9) + texture2D (_SplashTex, tmpvar_11)).xyz;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  lowp vec4 c_12;
					  lowp vec4 c_13;
					  lowp float diff_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_14 = tmpvar_15;
					  c_13.xyz = ((tmpvar_4 * tmpvar_1) * diff_14);
					  c_13.w = tmpvar_8;
					  c_12.w = c_13.w;
					  c_12.xyz = (c_13.xyz + (tmpvar_4 * xlv_TEXCOORD3));
					  c_3.w = c_12.w;
					  highp float tmpvar_16;
					  tmpvar_16 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = mix (unity_FogColor.xyz, c_12.xyz, vec3(tmpvar_16));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  highp vec3 lightColor0_9;
					  lightColor0_9 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_10;
					  lightColor1_10 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_11;
					  lightColor2_11 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_12;
					  lightColor3_12 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_13;
					  lightAttenSq_13 = unity_4LightAtten0;
					  highp vec3 normal_14;
					  normal_14 = worldNormal_1;
					  highp vec3 col_15;
					  highp vec4 ndotl_16;
					  highp vec4 lengthSq_17;
					  highp vec4 tmpvar_18;
					  tmpvar_18 = (unity_4LightPosX0 - tmpvar_6.x);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = (unity_4LightPosY0 - tmpvar_6.y);
					  highp vec4 tmpvar_20;
					  tmpvar_20 = (unity_4LightPosZ0 - tmpvar_6.z);
					  lengthSq_17 = (tmpvar_18 * tmpvar_18);
					  lengthSq_17 = (lengthSq_17 + (tmpvar_19 * tmpvar_19));
					  lengthSq_17 = (lengthSq_17 + (tmpvar_20 * tmpvar_20));
					  highp vec4 tmpvar_21;
					  tmpvar_21 = max (lengthSq_17, vec4(1e-06, 1e-06, 1e-06, 1e-06));
					  lengthSq_17 = tmpvar_21;
					  ndotl_16 = (tmpvar_18 * normal_14.x);
					  ndotl_16 = (ndotl_16 + (tmpvar_19 * normal_14.y));
					  ndotl_16 = (ndotl_16 + (tmpvar_20 * normal_14.z));
					  highp vec4 tmpvar_22;
					  tmpvar_22 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_16 * inversesqrt(tmpvar_21)));
					  ndotl_16 = tmpvar_22;
					  highp vec4 tmpvar_23;
					  tmpvar_23 = (tmpvar_22 * (1.0/((1.0 + 
					    (tmpvar_21 * lightAttenSq_13)
					  ))));
					  col_15 = (lightColor0_9 * tmpvar_23.x);
					  col_15 = (col_15 + (lightColor1_10 * tmpvar_23.y));
					  col_15 = (col_15 + (lightColor2_11 * tmpvar_23.z));
					  col_15 = (col_15 + (lightColor3_12 * tmpvar_23.w));
					  tmpvar_3 = col_15;
					  mediump vec3 normal_24;
					  normal_24 = worldNormal_1;
					  mediump vec3 ambient_25;
					  mediump vec4 tmpvar_26;
					  tmpvar_26.w = 1.0;
					  tmpvar_26.xyz = normal_24;
					  mediump vec3 res_27;
					  mediump vec3 x_28;
					  x_28.x = dot (unity_SHAr, tmpvar_26);
					  x_28.y = dot (unity_SHAg, tmpvar_26);
					  x_28.z = dot (unity_SHAb, tmpvar_26);
					  mediump vec3 x1_29;
					  mediump vec4 tmpvar_30;
					  tmpvar_30 = (normal_24.xyzz * normal_24.yzzx);
					  x1_29.x = dot (unity_SHBr, tmpvar_30);
					  x1_29.y = dot (unity_SHBg, tmpvar_30);
					  x1_29.z = dot (unity_SHBb, tmpvar_30);
					  res_27 = (x_28 + (x1_29 + (unity_SHC.xyz * 
					    ((normal_24.x * normal_24.x) - (normal_24.y * normal_24.y))
					  )));
					  mediump vec3 tmpvar_31;
					  tmpvar_31 = max (((1.055 * 
					    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_27 = tmpvar_31;
					  ambient_25 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), tmpvar_31));
					  tmpvar_3 = ambient_25;
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_6;
					  xlv_TEXCOORD3 = ambient_25;
					  xlv_TEXCOORD4 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp float tmpvar_8;
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_10;
					  tmpvar_10 = (_Time.x * _WaveSpeed);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + tmpvar_10);
					  highp vec2 tmpvar_11;
					  tmpvar_11.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_11.y = (xlv_TEXCOORD0.y + (tmpvar_10 * 0.5));
					  tmpvar_8 = (_Transparency + 0.5);
					  tmpvar_4 = (texture2D (_SplashTex, tmpvar_9) + texture2D (_SplashTex, tmpvar_11)).xyz;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  lowp vec4 c_12;
					  lowp vec4 c_13;
					  lowp float diff_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_14 = tmpvar_15;
					  c_13.xyz = ((tmpvar_4 * tmpvar_1) * diff_14);
					  c_13.w = tmpvar_8;
					  c_12.w = c_13.w;
					  c_12.xyz = (c_13.xyz + (tmpvar_4 * xlv_TEXCOORD3));
					  c_3.w = c_12.w;
					  highp float tmpvar_16;
					  tmpvar_16 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = mix (unity_FogColor.xyz, c_12.xyz, vec3(tmpvar_16));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  highp vec3 lightColor0_9;
					  lightColor0_9 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_10;
					  lightColor1_10 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_11;
					  lightColor2_11 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_12;
					  lightColor3_12 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_13;
					  lightAttenSq_13 = unity_4LightAtten0;
					  highp vec3 normal_14;
					  normal_14 = worldNormal_1;
					  highp vec3 col_15;
					  highp vec4 ndotl_16;
					  highp vec4 lengthSq_17;
					  highp vec4 tmpvar_18;
					  tmpvar_18 = (unity_4LightPosX0 - tmpvar_6.x);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = (unity_4LightPosY0 - tmpvar_6.y);
					  highp vec4 tmpvar_20;
					  tmpvar_20 = (unity_4LightPosZ0 - tmpvar_6.z);
					  lengthSq_17 = (tmpvar_18 * tmpvar_18);
					  lengthSq_17 = (lengthSq_17 + (tmpvar_19 * tmpvar_19));
					  lengthSq_17 = (lengthSq_17 + (tmpvar_20 * tmpvar_20));
					  highp vec4 tmpvar_21;
					  tmpvar_21 = max (lengthSq_17, vec4(1e-06, 1e-06, 1e-06, 1e-06));
					  lengthSq_17 = tmpvar_21;
					  ndotl_16 = (tmpvar_18 * normal_14.x);
					  ndotl_16 = (ndotl_16 + (tmpvar_19 * normal_14.y));
					  ndotl_16 = (ndotl_16 + (tmpvar_20 * normal_14.z));
					  highp vec4 tmpvar_22;
					  tmpvar_22 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_16 * inversesqrt(tmpvar_21)));
					  ndotl_16 = tmpvar_22;
					  highp vec4 tmpvar_23;
					  tmpvar_23 = (tmpvar_22 * (1.0/((1.0 + 
					    (tmpvar_21 * lightAttenSq_13)
					  ))));
					  col_15 = (lightColor0_9 * tmpvar_23.x);
					  col_15 = (col_15 + (lightColor1_10 * tmpvar_23.y));
					  col_15 = (col_15 + (lightColor2_11 * tmpvar_23.z));
					  col_15 = (col_15 + (lightColor3_12 * tmpvar_23.w));
					  tmpvar_3 = col_15;
					  mediump vec3 normal_24;
					  normal_24 = worldNormal_1;
					  mediump vec3 ambient_25;
					  mediump vec4 tmpvar_26;
					  tmpvar_26.w = 1.0;
					  tmpvar_26.xyz = normal_24;
					  mediump vec3 res_27;
					  mediump vec3 x_28;
					  x_28.x = dot (unity_SHAr, tmpvar_26);
					  x_28.y = dot (unity_SHAg, tmpvar_26);
					  x_28.z = dot (unity_SHAb, tmpvar_26);
					  mediump vec3 x1_29;
					  mediump vec4 tmpvar_30;
					  tmpvar_30 = (normal_24.xyzz * normal_24.yzzx);
					  x1_29.x = dot (unity_SHBr, tmpvar_30);
					  x1_29.y = dot (unity_SHBg, tmpvar_30);
					  x1_29.z = dot (unity_SHBb, tmpvar_30);
					  res_27 = (x_28 + (x1_29 + (unity_SHC.xyz * 
					    ((normal_24.x * normal_24.x) - (normal_24.y * normal_24.y))
					  )));
					  mediump vec3 tmpvar_31;
					  tmpvar_31 = max (((1.055 * 
					    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_27 = tmpvar_31;
					  ambient_25 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), tmpvar_31));
					  tmpvar_3 = ambient_25;
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_6;
					  xlv_TEXCOORD3 = ambient_25;
					  xlv_TEXCOORD4 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp float tmpvar_8;
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_10;
					  tmpvar_10 = (_Time.x * _WaveSpeed);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + tmpvar_10);
					  highp vec2 tmpvar_11;
					  tmpvar_11.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_11.y = (xlv_TEXCOORD0.y + (tmpvar_10 * 0.5));
					  tmpvar_8 = (_Transparency + 0.5);
					  tmpvar_4 = (texture2D (_SplashTex, tmpvar_9) + texture2D (_SplashTex, tmpvar_11)).xyz;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  lowp vec4 c_12;
					  lowp vec4 c_13;
					  lowp float diff_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_14 = tmpvar_15;
					  c_13.xyz = ((tmpvar_4 * tmpvar_1) * diff_14);
					  c_13.w = tmpvar_8;
					  c_12.w = c_13.w;
					  c_12.xyz = (c_13.xyz + (tmpvar_4 * xlv_TEXCOORD3));
					  c_3.w = c_12.w;
					  highp float tmpvar_16;
					  tmpvar_16 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = mix (unity_FogColor.xyz, c_12.xyz, vec3(tmpvar_16));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES"
				}
			}
		}
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha One, SrcAlpha One
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			GpuProgramID 130183
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					Keywords { "POINT" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_WorldToObject[0].xyz;
					  tmpvar_4[1] = unity_WorldToObject[1].xyz;
					  tmpvar_4[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
					  worldNormal_1 = tmpvar_5;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  highp vec3 lightCoord_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp float tmpvar_7;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_9;
					  tmpvar_9 = (_Time.x * _WaveSpeed);
					  tmpvar_8.y = (xlv_TEXCOORD0.y + tmpvar_9);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + (tmpvar_9 * 0.5));
					  tmpvar_7 = (_Transparency + 0.5);
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = xlv_TEXCOORD2;
					  lightCoord_3 = (unity_WorldToLight * tmpvar_11).xyz;
					  highp float tmpvar_12;
					  tmpvar_12 = dot (lightCoord_3, lightCoord_3);
					  lowp float tmpvar_13;
					  tmpvar_13 = texture2D (_LightTexture0, vec2(tmpvar_12)).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  tmpvar_1 = (tmpvar_1 * tmpvar_13);
					  lowp vec4 c_14;
					  lowp vec4 c_15;
					  lowp float diff_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_16 = tmpvar_17;
					  c_15.xyz = (((texture2D (_SplashTex, tmpvar_8) + texture2D (_SplashTex, tmpvar_10)).xyz * tmpvar_1) * diff_16);
					  c_15.w = tmpvar_7;
					  c_14.w = c_15.w;
					  c_14.xyz = c_15.xyz;
					  gl_FragData[0] = c_14;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "POINT" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_WorldToObject[0].xyz;
					  tmpvar_4[1] = unity_WorldToObject[1].xyz;
					  tmpvar_4[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
					  worldNormal_1 = tmpvar_5;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  highp vec3 lightCoord_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp float tmpvar_7;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_9;
					  tmpvar_9 = (_Time.x * _WaveSpeed);
					  tmpvar_8.y = (xlv_TEXCOORD0.y + tmpvar_9);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + (tmpvar_9 * 0.5));
					  tmpvar_7 = (_Transparency + 0.5);
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = xlv_TEXCOORD2;
					  lightCoord_3 = (unity_WorldToLight * tmpvar_11).xyz;
					  highp float tmpvar_12;
					  tmpvar_12 = dot (lightCoord_3, lightCoord_3);
					  lowp float tmpvar_13;
					  tmpvar_13 = texture2D (_LightTexture0, vec2(tmpvar_12)).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  tmpvar_1 = (tmpvar_1 * tmpvar_13);
					  lowp vec4 c_14;
					  lowp vec4 c_15;
					  lowp float diff_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_16 = tmpvar_17;
					  c_15.xyz = (((texture2D (_SplashTex, tmpvar_8) + texture2D (_SplashTex, tmpvar_10)).xyz * tmpvar_1) * diff_16);
					  c_15.w = tmpvar_7;
					  c_14.w = c_15.w;
					  c_14.xyz = c_15.xyz;
					  gl_FragData[0] = c_14;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "POINT" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_WorldToObject[0].xyz;
					  tmpvar_4[1] = unity_WorldToObject[1].xyz;
					  tmpvar_4[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
					  worldNormal_1 = tmpvar_5;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  highp vec3 lightCoord_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp float tmpvar_7;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_9;
					  tmpvar_9 = (_Time.x * _WaveSpeed);
					  tmpvar_8.y = (xlv_TEXCOORD0.y + tmpvar_9);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + (tmpvar_9 * 0.5));
					  tmpvar_7 = (_Transparency + 0.5);
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = xlv_TEXCOORD2;
					  lightCoord_3 = (unity_WorldToLight * tmpvar_11).xyz;
					  highp float tmpvar_12;
					  tmpvar_12 = dot (lightCoord_3, lightCoord_3);
					  lowp float tmpvar_13;
					  tmpvar_13 = texture2D (_LightTexture0, vec2(tmpvar_12)).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  tmpvar_1 = (tmpvar_1 * tmpvar_13);
					  lowp vec4 c_14;
					  lowp vec4 c_15;
					  lowp float diff_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_16 = tmpvar_17;
					  c_15.xyz = (((texture2D (_SplashTex, tmpvar_8) + texture2D (_SplashTex, tmpvar_10)).xyz * tmpvar_1) * diff_16);
					  c_15.w = tmpvar_7;
					  c_14.w = c_15.w;
					  c_14.xyz = c_15.xyz;
					  gl_FragData[0] = c_14;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_WorldToObject[0].xyz;
					  tmpvar_4[1] = unity_WorldToObject[1].xyz;
					  tmpvar_4[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
					  worldNormal_1 = tmpvar_5;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 lightDir_4;
					  mediump vec3 tmpvar_5;
					  tmpvar_5 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_5;
					  tmpvar_3 = xlv_TEXCOORD1;
					  lowp float tmpvar_6;
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_8;
					  tmpvar_8 = (_Time.x * _WaveSpeed);
					  tmpvar_7.y = (xlv_TEXCOORD0.y + tmpvar_8);
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + (tmpvar_8 * 0.5));
					  tmpvar_6 = (_Transparency + 0.5);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_4;
					  lowp vec4 c_10;
					  lowp vec4 c_11;
					  lowp float diff_12;
					  mediump float tmpvar_13;
					  tmpvar_13 = max (0.0, dot (tmpvar_3, tmpvar_2));
					  diff_12 = tmpvar_13;
					  c_11.xyz = (((texture2D (_SplashTex, tmpvar_7) + texture2D (_SplashTex, tmpvar_9)).xyz * tmpvar_1) * diff_12);
					  c_11.w = tmpvar_6;
					  c_10.w = c_11.w;
					  c_10.xyz = c_11.xyz;
					  gl_FragData[0] = c_10;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_WorldToObject[0].xyz;
					  tmpvar_4[1] = unity_WorldToObject[1].xyz;
					  tmpvar_4[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
					  worldNormal_1 = tmpvar_5;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 lightDir_4;
					  mediump vec3 tmpvar_5;
					  tmpvar_5 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_5;
					  tmpvar_3 = xlv_TEXCOORD1;
					  lowp float tmpvar_6;
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_8;
					  tmpvar_8 = (_Time.x * _WaveSpeed);
					  tmpvar_7.y = (xlv_TEXCOORD0.y + tmpvar_8);
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + (tmpvar_8 * 0.5));
					  tmpvar_6 = (_Transparency + 0.5);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_4;
					  lowp vec4 c_10;
					  lowp vec4 c_11;
					  lowp float diff_12;
					  mediump float tmpvar_13;
					  tmpvar_13 = max (0.0, dot (tmpvar_3, tmpvar_2));
					  diff_12 = tmpvar_13;
					  c_11.xyz = (((texture2D (_SplashTex, tmpvar_7) + texture2D (_SplashTex, tmpvar_9)).xyz * tmpvar_1) * diff_12);
					  c_11.w = tmpvar_6;
					  c_10.w = c_11.w;
					  c_10.xyz = c_11.xyz;
					  gl_FragData[0] = c_10;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_WorldToObject[0].xyz;
					  tmpvar_4[1] = unity_WorldToObject[1].xyz;
					  tmpvar_4[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
					  worldNormal_1 = tmpvar_5;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 lightDir_4;
					  mediump vec3 tmpvar_5;
					  tmpvar_5 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_5;
					  tmpvar_3 = xlv_TEXCOORD1;
					  lowp float tmpvar_6;
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_8;
					  tmpvar_8 = (_Time.x * _WaveSpeed);
					  tmpvar_7.y = (xlv_TEXCOORD0.y + tmpvar_8);
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + (tmpvar_8 * 0.5));
					  tmpvar_6 = (_Transparency + 0.5);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_4;
					  lowp vec4 c_10;
					  lowp vec4 c_11;
					  lowp float diff_12;
					  mediump float tmpvar_13;
					  tmpvar_13 = max (0.0, dot (tmpvar_3, tmpvar_2));
					  diff_12 = tmpvar_13;
					  c_11.xyz = (((texture2D (_SplashTex, tmpvar_7) + texture2D (_SplashTex, tmpvar_9)).xyz * tmpvar_1) * diff_12);
					  c_11.w = tmpvar_6;
					  c_10.w = c_11.w;
					  c_10.xyz = c_11.xyz;
					  gl_FragData[0] = c_10;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "SPOT" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_WorldToObject[0].xyz;
					  tmpvar_4[1] = unity_WorldToObject[1].xyz;
					  tmpvar_4[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
					  worldNormal_1 = tmpvar_5;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp float atten_3;
					  highp vec4 lightCoord_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp float tmpvar_8;
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_10;
					  tmpvar_10 = (_Time.x * _WaveSpeed);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + tmpvar_10);
					  highp vec2 tmpvar_11;
					  tmpvar_11.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_11.y = (xlv_TEXCOORD0.y + (tmpvar_10 * 0.5));
					  tmpvar_8 = (_Transparency + 0.5);
					  highp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_12);
					  lowp vec4 tmpvar_13;
					  highp vec2 P_14;
					  P_14 = ((lightCoord_4.xy / lightCoord_4.w) + 0.5);
					  tmpvar_13 = texture2D (_LightTexture0, P_14);
					  highp float tmpvar_15;
					  tmpvar_15 = dot (lightCoord_4.xyz, lightCoord_4.xyz);
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = texture2D (_LightTextureB0, vec2(tmpvar_15));
					  highp float tmpvar_17;
					  tmpvar_17 = ((float(
					    (lightCoord_4.z > 0.0)
					  ) * tmpvar_13.w) * tmpvar_16.w);
					  atten_3 = tmpvar_17;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * atten_3);
					  lowp vec4 c_18;
					  lowp vec4 c_19;
					  lowp float diff_20;
					  mediump float tmpvar_21;
					  tmpvar_21 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_20 = tmpvar_21;
					  c_19.xyz = (((texture2D (_SplashTex, tmpvar_9) + texture2D (_SplashTex, tmpvar_11)).xyz * tmpvar_1) * diff_20);
					  c_19.w = tmpvar_8;
					  c_18.w = c_19.w;
					  c_18.xyz = c_19.xyz;
					  gl_FragData[0] = c_18;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "SPOT" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_WorldToObject[0].xyz;
					  tmpvar_4[1] = unity_WorldToObject[1].xyz;
					  tmpvar_4[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
					  worldNormal_1 = tmpvar_5;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp float atten_3;
					  highp vec4 lightCoord_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp float tmpvar_8;
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_10;
					  tmpvar_10 = (_Time.x * _WaveSpeed);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + tmpvar_10);
					  highp vec2 tmpvar_11;
					  tmpvar_11.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_11.y = (xlv_TEXCOORD0.y + (tmpvar_10 * 0.5));
					  tmpvar_8 = (_Transparency + 0.5);
					  highp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_12);
					  lowp vec4 tmpvar_13;
					  highp vec2 P_14;
					  P_14 = ((lightCoord_4.xy / lightCoord_4.w) + 0.5);
					  tmpvar_13 = texture2D (_LightTexture0, P_14);
					  highp float tmpvar_15;
					  tmpvar_15 = dot (lightCoord_4.xyz, lightCoord_4.xyz);
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = texture2D (_LightTextureB0, vec2(tmpvar_15));
					  highp float tmpvar_17;
					  tmpvar_17 = ((float(
					    (lightCoord_4.z > 0.0)
					  ) * tmpvar_13.w) * tmpvar_16.w);
					  atten_3 = tmpvar_17;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * atten_3);
					  lowp vec4 c_18;
					  lowp vec4 c_19;
					  lowp float diff_20;
					  mediump float tmpvar_21;
					  tmpvar_21 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_20 = tmpvar_21;
					  c_19.xyz = (((texture2D (_SplashTex, tmpvar_9) + texture2D (_SplashTex, tmpvar_11)).xyz * tmpvar_1) * diff_20);
					  c_19.w = tmpvar_8;
					  c_18.w = c_19.w;
					  c_18.xyz = c_19.xyz;
					  gl_FragData[0] = c_18;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "SPOT" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_WorldToObject[0].xyz;
					  tmpvar_4[1] = unity_WorldToObject[1].xyz;
					  tmpvar_4[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
					  worldNormal_1 = tmpvar_5;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp float atten_3;
					  highp vec4 lightCoord_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp float tmpvar_8;
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_10;
					  tmpvar_10 = (_Time.x * _WaveSpeed);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + tmpvar_10);
					  highp vec2 tmpvar_11;
					  tmpvar_11.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_11.y = (xlv_TEXCOORD0.y + (tmpvar_10 * 0.5));
					  tmpvar_8 = (_Transparency + 0.5);
					  highp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_12);
					  lowp vec4 tmpvar_13;
					  highp vec2 P_14;
					  P_14 = ((lightCoord_4.xy / lightCoord_4.w) + 0.5);
					  tmpvar_13 = texture2D (_LightTexture0, P_14);
					  highp float tmpvar_15;
					  tmpvar_15 = dot (lightCoord_4.xyz, lightCoord_4.xyz);
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = texture2D (_LightTextureB0, vec2(tmpvar_15));
					  highp float tmpvar_17;
					  tmpvar_17 = ((float(
					    (lightCoord_4.z > 0.0)
					  ) * tmpvar_13.w) * tmpvar_16.w);
					  atten_3 = tmpvar_17;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * atten_3);
					  lowp vec4 c_18;
					  lowp vec4 c_19;
					  lowp float diff_20;
					  mediump float tmpvar_21;
					  tmpvar_21 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_20 = tmpvar_21;
					  c_19.xyz = (((texture2D (_SplashTex, tmpvar_9) + texture2D (_SplashTex, tmpvar_11)).xyz * tmpvar_1) * diff_20);
					  c_19.w = tmpvar_8;
					  c_18.w = c_19.w;
					  c_18.xyz = c_19.xyz;
					  gl_FragData[0] = c_18;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_WorldToObject[0].xyz;
					  tmpvar_4[1] = unity_WorldToObject[1].xyz;
					  tmpvar_4[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
					  worldNormal_1 = tmpvar_5;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  highp vec3 lightCoord_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp float tmpvar_7;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_9;
					  tmpvar_9 = (_Time.x * _WaveSpeed);
					  tmpvar_8.y = (xlv_TEXCOORD0.y + tmpvar_9);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + (tmpvar_9 * 0.5));
					  tmpvar_7 = (_Transparency + 0.5);
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = xlv_TEXCOORD2;
					  lightCoord_3 = (unity_WorldToLight * tmpvar_11).xyz;
					  highp float tmpvar_12;
					  tmpvar_12 = dot (lightCoord_3, lightCoord_3);
					  lowp float tmpvar_13;
					  tmpvar_13 = (texture2D (_LightTextureB0, vec2(tmpvar_12)).w * textureCube (_LightTexture0, lightCoord_3).w);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  tmpvar_1 = (tmpvar_1 * tmpvar_13);
					  lowp vec4 c_14;
					  lowp vec4 c_15;
					  lowp float diff_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_16 = tmpvar_17;
					  c_15.xyz = (((texture2D (_SplashTex, tmpvar_8) + texture2D (_SplashTex, tmpvar_10)).xyz * tmpvar_1) * diff_16);
					  c_15.w = tmpvar_7;
					  c_14.w = c_15.w;
					  c_14.xyz = c_15.xyz;
					  gl_FragData[0] = c_14;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_WorldToObject[0].xyz;
					  tmpvar_4[1] = unity_WorldToObject[1].xyz;
					  tmpvar_4[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
					  worldNormal_1 = tmpvar_5;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  highp vec3 lightCoord_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp float tmpvar_7;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_9;
					  tmpvar_9 = (_Time.x * _WaveSpeed);
					  tmpvar_8.y = (xlv_TEXCOORD0.y + tmpvar_9);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + (tmpvar_9 * 0.5));
					  tmpvar_7 = (_Transparency + 0.5);
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = xlv_TEXCOORD2;
					  lightCoord_3 = (unity_WorldToLight * tmpvar_11).xyz;
					  highp float tmpvar_12;
					  tmpvar_12 = dot (lightCoord_3, lightCoord_3);
					  lowp float tmpvar_13;
					  tmpvar_13 = (texture2D (_LightTextureB0, vec2(tmpvar_12)).w * textureCube (_LightTexture0, lightCoord_3).w);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  tmpvar_1 = (tmpvar_1 * tmpvar_13);
					  lowp vec4 c_14;
					  lowp vec4 c_15;
					  lowp float diff_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_16 = tmpvar_17;
					  c_15.xyz = (((texture2D (_SplashTex, tmpvar_8) + texture2D (_SplashTex, tmpvar_10)).xyz * tmpvar_1) * diff_16);
					  c_15.w = tmpvar_7;
					  c_14.w = c_15.w;
					  c_14.xyz = c_15.xyz;
					  gl_FragData[0] = c_14;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_WorldToObject[0].xyz;
					  tmpvar_4[1] = unity_WorldToObject[1].xyz;
					  tmpvar_4[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
					  worldNormal_1 = tmpvar_5;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  highp vec3 lightCoord_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp float tmpvar_7;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_9;
					  tmpvar_9 = (_Time.x * _WaveSpeed);
					  tmpvar_8.y = (xlv_TEXCOORD0.y + tmpvar_9);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + (tmpvar_9 * 0.5));
					  tmpvar_7 = (_Transparency + 0.5);
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = xlv_TEXCOORD2;
					  lightCoord_3 = (unity_WorldToLight * tmpvar_11).xyz;
					  highp float tmpvar_12;
					  tmpvar_12 = dot (lightCoord_3, lightCoord_3);
					  lowp float tmpvar_13;
					  tmpvar_13 = (texture2D (_LightTextureB0, vec2(tmpvar_12)).w * textureCube (_LightTexture0, lightCoord_3).w);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  tmpvar_1 = (tmpvar_1 * tmpvar_13);
					  lowp vec4 c_14;
					  lowp vec4 c_15;
					  lowp float diff_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_16 = tmpvar_17;
					  c_15.xyz = (((texture2D (_SplashTex, tmpvar_8) + texture2D (_SplashTex, tmpvar_10)).xyz * tmpvar_1) * diff_16);
					  c_15.w = tmpvar_7;
					  c_14.w = c_15.w;
					  c_14.xyz = c_15.xyz;
					  gl_FragData[0] = c_14;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_WorldToObject[0].xyz;
					  tmpvar_4[1] = unity_WorldToObject[1].xyz;
					  tmpvar_4[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
					  worldNormal_1 = tmpvar_5;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  highp vec2 lightCoord_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp float tmpvar_7;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_9;
					  tmpvar_9 = (_Time.x * _WaveSpeed);
					  tmpvar_8.y = (xlv_TEXCOORD0.y + tmpvar_9);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + (tmpvar_9 * 0.5));
					  tmpvar_7 = (_Transparency + 0.5);
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = xlv_TEXCOORD2;
					  lightCoord_3 = (unity_WorldToLight * tmpvar_11).xy;
					  lowp float tmpvar_12;
					  tmpvar_12 = texture2D (_LightTexture0, lightCoord_3).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  tmpvar_1 = (tmpvar_1 * tmpvar_12);
					  lowp vec4 c_13;
					  lowp vec4 c_14;
					  lowp float diff_15;
					  mediump float tmpvar_16;
					  tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_15 = tmpvar_16;
					  c_14.xyz = (((texture2D (_SplashTex, tmpvar_8) + texture2D (_SplashTex, tmpvar_10)).xyz * tmpvar_1) * diff_15);
					  c_14.w = tmpvar_7;
					  c_13.w = c_14.w;
					  c_13.xyz = c_14.xyz;
					  gl_FragData[0] = c_13;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_WorldToObject[0].xyz;
					  tmpvar_4[1] = unity_WorldToObject[1].xyz;
					  tmpvar_4[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
					  worldNormal_1 = tmpvar_5;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  highp vec2 lightCoord_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp float tmpvar_7;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_9;
					  tmpvar_9 = (_Time.x * _WaveSpeed);
					  tmpvar_8.y = (xlv_TEXCOORD0.y + tmpvar_9);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + (tmpvar_9 * 0.5));
					  tmpvar_7 = (_Transparency + 0.5);
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = xlv_TEXCOORD2;
					  lightCoord_3 = (unity_WorldToLight * tmpvar_11).xy;
					  lowp float tmpvar_12;
					  tmpvar_12 = texture2D (_LightTexture0, lightCoord_3).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  tmpvar_1 = (tmpvar_1 * tmpvar_12);
					  lowp vec4 c_13;
					  lowp vec4 c_14;
					  lowp float diff_15;
					  mediump float tmpvar_16;
					  tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_15 = tmpvar_16;
					  c_14.xyz = (((texture2D (_SplashTex, tmpvar_8) + texture2D (_SplashTex, tmpvar_10)).xyz * tmpvar_1) * diff_15);
					  c_14.w = tmpvar_7;
					  c_13.w = c_14.w;
					  c_13.xyz = c_14.xyz;
					  gl_FragData[0] = c_13;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_WorldToObject[0].xyz;
					  tmpvar_4[1] = unity_WorldToObject[1].xyz;
					  tmpvar_4[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
					  worldNormal_1 = tmpvar_5;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  highp vec2 lightCoord_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp float tmpvar_7;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_9;
					  tmpvar_9 = (_Time.x * _WaveSpeed);
					  tmpvar_8.y = (xlv_TEXCOORD0.y + tmpvar_9);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + (tmpvar_9 * 0.5));
					  tmpvar_7 = (_Transparency + 0.5);
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = xlv_TEXCOORD2;
					  lightCoord_3 = (unity_WorldToLight * tmpvar_11).xy;
					  lowp float tmpvar_12;
					  tmpvar_12 = texture2D (_LightTexture0, lightCoord_3).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  tmpvar_1 = (tmpvar_1 * tmpvar_12);
					  lowp vec4 c_13;
					  lowp vec4 c_14;
					  lowp float diff_15;
					  mediump float tmpvar_16;
					  tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_15 = tmpvar_16;
					  c_14.xyz = (((texture2D (_SplashTex, tmpvar_8) + texture2D (_SplashTex, tmpvar_10)).xyz * tmpvar_1) * diff_15);
					  c_14.w = tmpvar_7;
					  c_13.w = c_14.w;
					  c_13.xyz = c_14.xyz;
					  gl_FragData[0] = c_13;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  highp vec3 lightCoord_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp float tmpvar_8;
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_10;
					  tmpvar_10 = (_Time.x * _WaveSpeed);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + tmpvar_10);
					  highp vec2 tmpvar_11;
					  tmpvar_11.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_11.y = (xlv_TEXCOORD0.y + (tmpvar_10 * 0.5));
					  tmpvar_8 = (_Transparency + 0.5);
					  highp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_12).xyz;
					  highp float tmpvar_13;
					  tmpvar_13 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_14;
					  tmpvar_14 = texture2D (_LightTexture0, vec2(tmpvar_13)).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_14);
					  lowp vec4 c_15;
					  lowp vec4 c_16;
					  lowp float diff_17;
					  mediump float tmpvar_18;
					  tmpvar_18 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_17 = tmpvar_18;
					  c_16.xyz = (((texture2D (_SplashTex, tmpvar_9) + texture2D (_SplashTex, tmpvar_11)).xyz * tmpvar_1) * diff_17);
					  c_16.w = tmpvar_8;
					  c_15.w = c_16.w;
					  c_15.xyz = c_16.xyz;
					  c_3.w = c_15.w;
					  highp float tmpvar_19;
					  tmpvar_19 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
					  c_3.xyz = (c_16.xyz * vec3(tmpvar_19));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  highp vec3 lightCoord_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp float tmpvar_8;
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_10;
					  tmpvar_10 = (_Time.x * _WaveSpeed);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + tmpvar_10);
					  highp vec2 tmpvar_11;
					  tmpvar_11.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_11.y = (xlv_TEXCOORD0.y + (tmpvar_10 * 0.5));
					  tmpvar_8 = (_Transparency + 0.5);
					  highp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_12).xyz;
					  highp float tmpvar_13;
					  tmpvar_13 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_14;
					  tmpvar_14 = texture2D (_LightTexture0, vec2(tmpvar_13)).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_14);
					  lowp vec4 c_15;
					  lowp vec4 c_16;
					  lowp float diff_17;
					  mediump float tmpvar_18;
					  tmpvar_18 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_17 = tmpvar_18;
					  c_16.xyz = (((texture2D (_SplashTex, tmpvar_9) + texture2D (_SplashTex, tmpvar_11)).xyz * tmpvar_1) * diff_17);
					  c_16.w = tmpvar_8;
					  c_15.w = c_16.w;
					  c_15.xyz = c_16.xyz;
					  c_3.w = c_15.w;
					  highp float tmpvar_19;
					  tmpvar_19 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
					  c_3.xyz = (c_16.xyz * vec3(tmpvar_19));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  highp vec3 lightCoord_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp float tmpvar_8;
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_10;
					  tmpvar_10 = (_Time.x * _WaveSpeed);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + tmpvar_10);
					  highp vec2 tmpvar_11;
					  tmpvar_11.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_11.y = (xlv_TEXCOORD0.y + (tmpvar_10 * 0.5));
					  tmpvar_8 = (_Transparency + 0.5);
					  highp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_12).xyz;
					  highp float tmpvar_13;
					  tmpvar_13 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_14;
					  tmpvar_14 = texture2D (_LightTexture0, vec2(tmpvar_13)).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_14);
					  lowp vec4 c_15;
					  lowp vec4 c_16;
					  lowp float diff_17;
					  mediump float tmpvar_18;
					  tmpvar_18 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_17 = tmpvar_18;
					  c_16.xyz = (((texture2D (_SplashTex, tmpvar_9) + texture2D (_SplashTex, tmpvar_11)).xyz * tmpvar_1) * diff_17);
					  c_16.w = tmpvar_8;
					  c_15.w = c_16.w;
					  c_15.xyz = c_16.xyz;
					  c_3.w = c_15.w;
					  highp float tmpvar_19;
					  tmpvar_19 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
					  c_3.xyz = (c_16.xyz * vec3(tmpvar_19));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp float tmpvar_7;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_9;
					  tmpvar_9 = (_Time.x * _WaveSpeed);
					  tmpvar_8.y = (xlv_TEXCOORD0.y + tmpvar_9);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + (tmpvar_9 * 0.5));
					  tmpvar_7 = (_Transparency + 0.5);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_11;
					  lowp vec4 c_12;
					  lowp float diff_13;
					  mediump float tmpvar_14;
					  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_13 = tmpvar_14;
					  c_12.xyz = (((texture2D (_SplashTex, tmpvar_8) + texture2D (_SplashTex, tmpvar_10)).xyz * tmpvar_1) * diff_13);
					  c_12.w = tmpvar_7;
					  c_11.w = c_12.w;
					  c_11.xyz = c_12.xyz;
					  c_3.w = c_11.w;
					  highp float tmpvar_15;
					  tmpvar_15 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
					  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp float tmpvar_7;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_9;
					  tmpvar_9 = (_Time.x * _WaveSpeed);
					  tmpvar_8.y = (xlv_TEXCOORD0.y + tmpvar_9);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + (tmpvar_9 * 0.5));
					  tmpvar_7 = (_Transparency + 0.5);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_11;
					  lowp vec4 c_12;
					  lowp float diff_13;
					  mediump float tmpvar_14;
					  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_13 = tmpvar_14;
					  c_12.xyz = (((texture2D (_SplashTex, tmpvar_8) + texture2D (_SplashTex, tmpvar_10)).xyz * tmpvar_1) * diff_13);
					  c_12.w = tmpvar_7;
					  c_11.w = c_12.w;
					  c_11.xyz = c_12.xyz;
					  c_3.w = c_11.w;
					  highp float tmpvar_15;
					  tmpvar_15 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
					  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp float tmpvar_7;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_9;
					  tmpvar_9 = (_Time.x * _WaveSpeed);
					  tmpvar_8.y = (xlv_TEXCOORD0.y + tmpvar_9);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + (tmpvar_9 * 0.5));
					  tmpvar_7 = (_Transparency + 0.5);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_11;
					  lowp vec4 c_12;
					  lowp float diff_13;
					  mediump float tmpvar_14;
					  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_13 = tmpvar_14;
					  c_12.xyz = (((texture2D (_SplashTex, tmpvar_8) + texture2D (_SplashTex, tmpvar_10)).xyz * tmpvar_1) * diff_13);
					  c_12.w = tmpvar_7;
					  c_11.w = c_12.w;
					  c_11.xyz = c_12.xyz;
					  c_3.w = c_11.w;
					  highp float tmpvar_15;
					  tmpvar_15 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
					  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp float atten_4;
					  highp vec4 lightCoord_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp float tmpvar_9;
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_11;
					  tmpvar_11 = (_Time.x * _WaveSpeed);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + tmpvar_11);
					  highp vec2 tmpvar_12;
					  tmpvar_12.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_12.y = (xlv_TEXCOORD0.y + (tmpvar_11 * 0.5));
					  tmpvar_9 = (_Transparency + 0.5);
					  highp vec4 tmpvar_13;
					  tmpvar_13.w = 1.0;
					  tmpvar_13.xyz = xlv_TEXCOORD2;
					  lightCoord_5 = (unity_WorldToLight * tmpvar_13);
					  lowp vec4 tmpvar_14;
					  highp vec2 P_15;
					  P_15 = ((lightCoord_5.xy / lightCoord_5.w) + 0.5);
					  tmpvar_14 = texture2D (_LightTexture0, P_15);
					  highp float tmpvar_16;
					  tmpvar_16 = dot (lightCoord_5.xyz, lightCoord_5.xyz);
					  lowp vec4 tmpvar_17;
					  tmpvar_17 = texture2D (_LightTextureB0, vec2(tmpvar_16));
					  highp float tmpvar_18;
					  tmpvar_18 = ((float(
					    (lightCoord_5.z > 0.0)
					  ) * tmpvar_14.w) * tmpvar_17.w);
					  atten_4 = tmpvar_18;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * atten_4);
					  lowp vec4 c_19;
					  lowp vec4 c_20;
					  lowp float diff_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = max (0.0, dot (tmpvar_6, tmpvar_2));
					  diff_21 = tmpvar_22;
					  c_20.xyz = (((texture2D (_SplashTex, tmpvar_10) + texture2D (_SplashTex, tmpvar_12)).xyz * tmpvar_1) * diff_21);
					  c_20.w = tmpvar_9;
					  c_19.w = c_20.w;
					  c_19.xyz = c_20.xyz;
					  c_3.w = c_19.w;
					  highp float tmpvar_23;
					  tmpvar_23 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
					  c_3.xyz = (c_20.xyz * vec3(tmpvar_23));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp float atten_4;
					  highp vec4 lightCoord_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp float tmpvar_9;
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_11;
					  tmpvar_11 = (_Time.x * _WaveSpeed);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + tmpvar_11);
					  highp vec2 tmpvar_12;
					  tmpvar_12.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_12.y = (xlv_TEXCOORD0.y + (tmpvar_11 * 0.5));
					  tmpvar_9 = (_Transparency + 0.5);
					  highp vec4 tmpvar_13;
					  tmpvar_13.w = 1.0;
					  tmpvar_13.xyz = xlv_TEXCOORD2;
					  lightCoord_5 = (unity_WorldToLight * tmpvar_13);
					  lowp vec4 tmpvar_14;
					  highp vec2 P_15;
					  P_15 = ((lightCoord_5.xy / lightCoord_5.w) + 0.5);
					  tmpvar_14 = texture2D (_LightTexture0, P_15);
					  highp float tmpvar_16;
					  tmpvar_16 = dot (lightCoord_5.xyz, lightCoord_5.xyz);
					  lowp vec4 tmpvar_17;
					  tmpvar_17 = texture2D (_LightTextureB0, vec2(tmpvar_16));
					  highp float tmpvar_18;
					  tmpvar_18 = ((float(
					    (lightCoord_5.z > 0.0)
					  ) * tmpvar_14.w) * tmpvar_17.w);
					  atten_4 = tmpvar_18;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * atten_4);
					  lowp vec4 c_19;
					  lowp vec4 c_20;
					  lowp float diff_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = max (0.0, dot (tmpvar_6, tmpvar_2));
					  diff_21 = tmpvar_22;
					  c_20.xyz = (((texture2D (_SplashTex, tmpvar_10) + texture2D (_SplashTex, tmpvar_12)).xyz * tmpvar_1) * diff_21);
					  c_20.w = tmpvar_9;
					  c_19.w = c_20.w;
					  c_19.xyz = c_20.xyz;
					  c_3.w = c_19.w;
					  highp float tmpvar_23;
					  tmpvar_23 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
					  c_3.xyz = (c_20.xyz * vec3(tmpvar_23));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp float atten_4;
					  highp vec4 lightCoord_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp float tmpvar_9;
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_11;
					  tmpvar_11 = (_Time.x * _WaveSpeed);
					  tmpvar_10.y = (xlv_TEXCOORD0.y + tmpvar_11);
					  highp vec2 tmpvar_12;
					  tmpvar_12.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_12.y = (xlv_TEXCOORD0.y + (tmpvar_11 * 0.5));
					  tmpvar_9 = (_Transparency + 0.5);
					  highp vec4 tmpvar_13;
					  tmpvar_13.w = 1.0;
					  tmpvar_13.xyz = xlv_TEXCOORD2;
					  lightCoord_5 = (unity_WorldToLight * tmpvar_13);
					  lowp vec4 tmpvar_14;
					  highp vec2 P_15;
					  P_15 = ((lightCoord_5.xy / lightCoord_5.w) + 0.5);
					  tmpvar_14 = texture2D (_LightTexture0, P_15);
					  highp float tmpvar_16;
					  tmpvar_16 = dot (lightCoord_5.xyz, lightCoord_5.xyz);
					  lowp vec4 tmpvar_17;
					  tmpvar_17 = texture2D (_LightTextureB0, vec2(tmpvar_16));
					  highp float tmpvar_18;
					  tmpvar_18 = ((float(
					    (lightCoord_5.z > 0.0)
					  ) * tmpvar_14.w) * tmpvar_17.w);
					  atten_4 = tmpvar_18;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * atten_4);
					  lowp vec4 c_19;
					  lowp vec4 c_20;
					  lowp float diff_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = max (0.0, dot (tmpvar_6, tmpvar_2));
					  diff_21 = tmpvar_22;
					  c_20.xyz = (((texture2D (_SplashTex, tmpvar_10) + texture2D (_SplashTex, tmpvar_12)).xyz * tmpvar_1) * diff_21);
					  c_20.w = tmpvar_9;
					  c_19.w = c_20.w;
					  c_19.xyz = c_20.xyz;
					  c_3.w = c_19.w;
					  highp float tmpvar_23;
					  tmpvar_23 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
					  c_3.xyz = (c_20.xyz * vec3(tmpvar_23));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  highp vec3 lightCoord_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp float tmpvar_8;
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_10;
					  tmpvar_10 = (_Time.x * _WaveSpeed);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + tmpvar_10);
					  highp vec2 tmpvar_11;
					  tmpvar_11.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_11.y = (xlv_TEXCOORD0.y + (tmpvar_10 * 0.5));
					  tmpvar_8 = (_Transparency + 0.5);
					  highp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_12).xyz;
					  highp float tmpvar_13;
					  tmpvar_13 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_14;
					  tmpvar_14 = (texture2D (_LightTextureB0, vec2(tmpvar_13)).w * textureCube (_LightTexture0, lightCoord_4).w);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_14);
					  lowp vec4 c_15;
					  lowp vec4 c_16;
					  lowp float diff_17;
					  mediump float tmpvar_18;
					  tmpvar_18 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_17 = tmpvar_18;
					  c_16.xyz = (((texture2D (_SplashTex, tmpvar_9) + texture2D (_SplashTex, tmpvar_11)).xyz * tmpvar_1) * diff_17);
					  c_16.w = tmpvar_8;
					  c_15.w = c_16.w;
					  c_15.xyz = c_16.xyz;
					  c_3.w = c_15.w;
					  highp float tmpvar_19;
					  tmpvar_19 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
					  c_3.xyz = (c_16.xyz * vec3(tmpvar_19));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  highp vec3 lightCoord_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp float tmpvar_8;
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_10;
					  tmpvar_10 = (_Time.x * _WaveSpeed);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + tmpvar_10);
					  highp vec2 tmpvar_11;
					  tmpvar_11.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_11.y = (xlv_TEXCOORD0.y + (tmpvar_10 * 0.5));
					  tmpvar_8 = (_Transparency + 0.5);
					  highp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_12).xyz;
					  highp float tmpvar_13;
					  tmpvar_13 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_14;
					  tmpvar_14 = (texture2D (_LightTextureB0, vec2(tmpvar_13)).w * textureCube (_LightTexture0, lightCoord_4).w);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_14);
					  lowp vec4 c_15;
					  lowp vec4 c_16;
					  lowp float diff_17;
					  mediump float tmpvar_18;
					  tmpvar_18 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_17 = tmpvar_18;
					  c_16.xyz = (((texture2D (_SplashTex, tmpvar_9) + texture2D (_SplashTex, tmpvar_11)).xyz * tmpvar_1) * diff_17);
					  c_16.w = tmpvar_8;
					  c_15.w = c_16.w;
					  c_15.xyz = c_16.xyz;
					  c_3.w = c_15.w;
					  highp float tmpvar_19;
					  tmpvar_19 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
					  c_3.xyz = (c_16.xyz * vec3(tmpvar_19));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  highp vec3 lightCoord_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp float tmpvar_8;
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_10;
					  tmpvar_10 = (_Time.x * _WaveSpeed);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + tmpvar_10);
					  highp vec2 tmpvar_11;
					  tmpvar_11.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_11.y = (xlv_TEXCOORD0.y + (tmpvar_10 * 0.5));
					  tmpvar_8 = (_Transparency + 0.5);
					  highp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_12).xyz;
					  highp float tmpvar_13;
					  tmpvar_13 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_14;
					  tmpvar_14 = (texture2D (_LightTextureB0, vec2(tmpvar_13)).w * textureCube (_LightTexture0, lightCoord_4).w);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_14);
					  lowp vec4 c_15;
					  lowp vec4 c_16;
					  lowp float diff_17;
					  mediump float tmpvar_18;
					  tmpvar_18 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_17 = tmpvar_18;
					  c_16.xyz = (((texture2D (_SplashTex, tmpvar_9) + texture2D (_SplashTex, tmpvar_11)).xyz * tmpvar_1) * diff_17);
					  c_16.w = tmpvar_8;
					  c_15.w = c_16.w;
					  c_15.xyz = c_16.xyz;
					  c_3.w = c_15.w;
					  highp float tmpvar_19;
					  tmpvar_19 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
					  c_3.xyz = (c_16.xyz * vec3(tmpvar_19));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  highp vec2 lightCoord_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp float tmpvar_8;
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_10;
					  tmpvar_10 = (_Time.x * _WaveSpeed);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + tmpvar_10);
					  highp vec2 tmpvar_11;
					  tmpvar_11.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_11.y = (xlv_TEXCOORD0.y + (tmpvar_10 * 0.5));
					  tmpvar_8 = (_Transparency + 0.5);
					  highp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_12).xy;
					  lowp float tmpvar_13;
					  tmpvar_13 = texture2D (_LightTexture0, lightCoord_4).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_13);
					  lowp vec4 c_14;
					  lowp vec4 c_15;
					  lowp float diff_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_16 = tmpvar_17;
					  c_15.xyz = (((texture2D (_SplashTex, tmpvar_9) + texture2D (_SplashTex, tmpvar_11)).xyz * tmpvar_1) * diff_16);
					  c_15.w = tmpvar_8;
					  c_14.w = c_15.w;
					  c_14.xyz = c_15.xyz;
					  c_3.w = c_14.w;
					  highp float tmpvar_18;
					  tmpvar_18 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
					  c_3.xyz = (c_15.xyz * vec3(tmpvar_18));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  highp vec2 lightCoord_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp float tmpvar_8;
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_10;
					  tmpvar_10 = (_Time.x * _WaveSpeed);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + tmpvar_10);
					  highp vec2 tmpvar_11;
					  tmpvar_11.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_11.y = (xlv_TEXCOORD0.y + (tmpvar_10 * 0.5));
					  tmpvar_8 = (_Transparency + 0.5);
					  highp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_12).xy;
					  lowp float tmpvar_13;
					  tmpvar_13 = texture2D (_LightTexture0, lightCoord_4).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_13);
					  lowp vec4 c_14;
					  lowp vec4 c_15;
					  lowp float diff_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_16 = tmpvar_17;
					  c_15.xyz = (((texture2D (_SplashTex, tmpvar_9) + texture2D (_SplashTex, tmpvar_11)).xyz * tmpvar_1) * diff_16);
					  c_15.w = tmpvar_8;
					  c_14.w = c_15.w;
					  c_14.xyz = c_15.xyz;
					  c_3.w = c_14.w;
					  highp float tmpvar_18;
					  tmpvar_18 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
					  c_3.xyz = (c_15.xyz * vec3(tmpvar_18));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _SplashTex;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  highp vec2 lightCoord_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp float tmpvar_8;
					  highp vec2 tmpvar_9;
					  tmpvar_9.x = xlv_TEXCOORD0.x;
					  highp float tmpvar_10;
					  tmpvar_10 = (_Time.x * _WaveSpeed);
					  tmpvar_9.y = (xlv_TEXCOORD0.y + tmpvar_10);
					  highp vec2 tmpvar_11;
					  tmpvar_11.x = (xlv_TEXCOORD0.x + 0.5);
					  tmpvar_11.y = (xlv_TEXCOORD0.y + (tmpvar_10 * 0.5));
					  tmpvar_8 = (_Transparency + 0.5);
					  highp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_12).xy;
					  lowp float tmpvar_13;
					  tmpvar_13 = texture2D (_LightTexture0, lightCoord_4).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_13);
					  lowp vec4 c_14;
					  lowp vec4 c_15;
					  lowp float diff_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_16 = tmpvar_17;
					  c_15.xyz = (((texture2D (_SplashTex, tmpvar_9) + texture2D (_SplashTex, tmpvar_11)).xyz * tmpvar_1) * diff_16);
					  c_15.w = tmpvar_8;
					  c_14.w = c_15.w;
					  c_14.xyz = c_15.xyz;
					  c_3.w = c_14.w;
					  highp float tmpvar_18;
					  tmpvar_18 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
					  c_3.xyz = (c_15.xyz * vec3(tmpvar_18));
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					Keywords { "POINT" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "POINT" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "POINT" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "SPOT" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "SPOT" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "SPOT" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES"
				}
			}
		}
	}
	Fallback "Bumped Specular"
}