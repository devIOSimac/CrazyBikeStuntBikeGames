Shader "EasyRoads3D/Diffuse" {
	Properties {
		_Color ("Main Color", Vector) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		LOD 200
		Tags { "RenderType" = "Opaque" }
		Pass {
			Name "FORWARD"
			LOD 200
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			Offset -3, -3
			GpuProgramID 21362
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  lowp float diff_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_10 = tmpvar_11;
					  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
					  c_9.w = tmpvar_7.w;
					  c_8.w = c_9.w;
					  c_8.xyz = c_9.xyz;
					  c_3.xyz = c_8.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  lowp float diff_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_10 = tmpvar_11;
					  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
					  c_9.w = tmpvar_7.w;
					  c_8.w = c_9.w;
					  c_8.xyz = c_9.xyz;
					  c_3.xyz = c_8.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  lowp float diff_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_10 = tmpvar_11;
					  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
					  c_9.w = tmpvar_7.w;
					  c_8.w = c_9.w;
					  c_8.xyz = c_9.xyz;
					  c_3.xyz = c_8.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_12);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  lowp float diff_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_10 = tmpvar_11;
					  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
					  c_9.w = tmpvar_7.w;
					  c_8.w = c_9.w;
					  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
					  c_3.xyz = c_8.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_12);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  lowp float diff_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_10 = tmpvar_11;
					  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
					  c_9.w = tmpvar_7.w;
					  c_8.w = c_9.w;
					  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
					  c_3.xyz = c_8.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_12);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  lowp float diff_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_10 = tmpvar_11;
					  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
					  c_9.w = tmpvar_7.w;
					  c_8.w = c_9.w;
					  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
					  c_3.xyz = c_8.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_6;
					  tmpvar_6[0] = unity_WorldToObject[0].xyz;
					  tmpvar_6[1] = unity_WorldToObject[1].xyz;
					  tmpvar_6[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = tmpvar_3;
					  xlv_TEXCOORD6 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 tmpvar_22;
					  tmpvar_22 = (tmpvar_2 * tmpvar_1);
					  tmpvar_2 = tmpvar_22;
					  lowp vec4 c_23;
					  lowp vec4 c_24;
					  lowp float diff_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_25 = tmpvar_26;
					  c_24.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_25);
					  c_24.w = tmpvar_9.w;
					  c_23.w = c_24.w;
					  c_23.xyz = c_24.xyz;
					  c_4.xyz = c_23.xyz;
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_6;
					  tmpvar_6[0] = unity_WorldToObject[0].xyz;
					  tmpvar_6[1] = unity_WorldToObject[1].xyz;
					  tmpvar_6[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = tmpvar_3;
					  xlv_TEXCOORD6 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 tmpvar_22;
					  tmpvar_22 = (tmpvar_2 * tmpvar_1);
					  tmpvar_2 = tmpvar_22;
					  lowp vec4 c_23;
					  lowp vec4 c_24;
					  lowp float diff_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_25 = tmpvar_26;
					  c_24.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_25);
					  c_24.w = tmpvar_9.w;
					  c_23.w = c_24.w;
					  c_23.xyz = c_24.xyz;
					  c_4.xyz = c_23.xyz;
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_6;
					  tmpvar_6[0] = unity_WorldToObject[0].xyz;
					  tmpvar_6[1] = unity_WorldToObject[1].xyz;
					  tmpvar_6[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = tmpvar_3;
					  xlv_TEXCOORD6 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 tmpvar_22;
					  tmpvar_22 = (tmpvar_2 * tmpvar_1);
					  tmpvar_2 = tmpvar_22;
					  lowp vec4 c_23;
					  lowp vec4 c_24;
					  lowp float diff_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_25 = tmpvar_26;
					  c_24.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_25);
					  c_24.w = tmpvar_9.w;
					  c_23.w = c_24.w;
					  c_23.xyz = c_24.xyz;
					  c_4.xyz = c_23.xyz;
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_6;
					  tmpvar_6[0] = unity_WorldToObject[0].xyz;
					  tmpvar_6[1] = unity_WorldToObject[1].xyz;
					  tmpvar_6[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  mediump vec3 normal_8;
					  normal_8 = worldNormal_1;
					  mediump vec3 x1_9;
					  mediump vec4 tmpvar_10;
					  tmpvar_10 = (normal_8.xyzz * normal_8.yzzx);
					  x1_9.x = dot (unity_SHBr, tmpvar_10);
					  x1_9.y = dot (unity_SHBg, tmpvar_10);
					  x1_9.z = dot (unity_SHBb, tmpvar_10);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = (x1_9 + (unity_SHC.xyz * (
					    (normal_8.x * normal_8.x)
					   - 
					    (normal_8.y * normal_8.y)
					  )));
					  xlv_TEXCOORD4 = tmpvar_3;
					  xlv_TEXCOORD6 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 normalWorld_22;
					  normalWorld_22 = tmpvar_6;
					  mediump vec3 tmpvar_23;
					  tmpvar_23 = (tmpvar_2 * tmpvar_1);
					  mediump vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalWorld_22;
					  mediump vec3 x_25;
					  x_25.x = dot (unity_SHAr, tmpvar_24);
					  x_25.y = dot (unity_SHAg, tmpvar_24);
					  x_25.z = dot (unity_SHAb, tmpvar_24);
					  mediump vec3 tmpvar_26;
					  tmpvar_26 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_2 = tmpvar_23;
					  lowp vec4 c_27;
					  lowp vec4 c_28;
					  lowp float diff_29;
					  mediump float tmpvar_30;
					  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_29 = tmpvar_30;
					  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
					  c_28.w = tmpvar_9.w;
					  c_27.w = c_28.w;
					  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
					  c_4.xyz = c_27.xyz;
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_6;
					  tmpvar_6[0] = unity_WorldToObject[0].xyz;
					  tmpvar_6[1] = unity_WorldToObject[1].xyz;
					  tmpvar_6[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  mediump vec3 normal_8;
					  normal_8 = worldNormal_1;
					  mediump vec3 x1_9;
					  mediump vec4 tmpvar_10;
					  tmpvar_10 = (normal_8.xyzz * normal_8.yzzx);
					  x1_9.x = dot (unity_SHBr, tmpvar_10);
					  x1_9.y = dot (unity_SHBg, tmpvar_10);
					  x1_9.z = dot (unity_SHBb, tmpvar_10);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = (x1_9 + (unity_SHC.xyz * (
					    (normal_8.x * normal_8.x)
					   - 
					    (normal_8.y * normal_8.y)
					  )));
					  xlv_TEXCOORD4 = tmpvar_3;
					  xlv_TEXCOORD6 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 normalWorld_22;
					  normalWorld_22 = tmpvar_6;
					  mediump vec3 tmpvar_23;
					  tmpvar_23 = (tmpvar_2 * tmpvar_1);
					  mediump vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalWorld_22;
					  mediump vec3 x_25;
					  x_25.x = dot (unity_SHAr, tmpvar_24);
					  x_25.y = dot (unity_SHAg, tmpvar_24);
					  x_25.z = dot (unity_SHAb, tmpvar_24);
					  mediump vec3 tmpvar_26;
					  tmpvar_26 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_2 = tmpvar_23;
					  lowp vec4 c_27;
					  lowp vec4 c_28;
					  lowp float diff_29;
					  mediump float tmpvar_30;
					  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_29 = tmpvar_30;
					  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
					  c_28.w = tmpvar_9.w;
					  c_27.w = c_28.w;
					  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
					  c_4.xyz = c_27.xyz;
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_6;
					  tmpvar_6[0] = unity_WorldToObject[0].xyz;
					  tmpvar_6[1] = unity_WorldToObject[1].xyz;
					  tmpvar_6[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  mediump vec3 normal_8;
					  normal_8 = worldNormal_1;
					  mediump vec3 x1_9;
					  mediump vec4 tmpvar_10;
					  tmpvar_10 = (normal_8.xyzz * normal_8.yzzx);
					  x1_9.x = dot (unity_SHBr, tmpvar_10);
					  x1_9.y = dot (unity_SHBg, tmpvar_10);
					  x1_9.z = dot (unity_SHBb, tmpvar_10);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = (x1_9 + (unity_SHC.xyz * (
					    (normal_8.x * normal_8.x)
					   - 
					    (normal_8.y * normal_8.y)
					  )));
					  xlv_TEXCOORD4 = tmpvar_3;
					  xlv_TEXCOORD6 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 normalWorld_22;
					  normalWorld_22 = tmpvar_6;
					  mediump vec3 tmpvar_23;
					  tmpvar_23 = (tmpvar_2 * tmpvar_1);
					  mediump vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalWorld_22;
					  mediump vec3 x_25;
					  x_25.x = dot (unity_SHAr, tmpvar_24);
					  x_25.y = dot (unity_SHAg, tmpvar_24);
					  x_25.z = dot (unity_SHAb, tmpvar_24);
					  mediump vec3 tmpvar_26;
					  tmpvar_26 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_2 = tmpvar_23;
					  lowp vec4 c_27;
					  lowp vec4 c_28;
					  lowp float diff_29;
					  mediump float tmpvar_30;
					  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_29 = tmpvar_30;
					  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
					  c_28.w = tmpvar_9.w;
					  c_27.w = c_28.w;
					  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
					  c_4.xyz = c_27.xyz;
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  lowp float diff_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_10 = tmpvar_11;
					  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
					  c_9.w = tmpvar_7.w;
					  c_8.w = c_9.w;
					  c_8.xyz = c_9.xyz;
					  c_3.xyz = c_8.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  lowp float diff_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_10 = tmpvar_11;
					  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
					  c_9.w = tmpvar_7.w;
					  c_8.w = c_9.w;
					  c_8.xyz = c_9.xyz;
					  c_3.xyz = c_8.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  lowp float diff_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_10 = tmpvar_11;
					  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
					  c_9.w = tmpvar_7.w;
					  c_8.w = c_9.w;
					  c_8.xyz = c_9.xyz;
					  c_3.xyz = c_8.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_5;
					  xlv_TEXCOORD3 = ambient_24;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  lowp float diff_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_10 = tmpvar_11;
					  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
					  c_9.w = tmpvar_7.w;
					  c_8.w = c_9.w;
					  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
					  c_3.xyz = c_8.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_5;
					  xlv_TEXCOORD3 = ambient_24;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  lowp float diff_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_10 = tmpvar_11;
					  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
					  c_9.w = tmpvar_7.w;
					  c_8.w = c_9.w;
					  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
					  c_3.xyz = c_8.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_5;
					  xlv_TEXCOORD3 = ambient_24;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  lowp float diff_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_10 = tmpvar_11;
					  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
					  c_9.w = tmpvar_7.w;
					  c_8.w = c_9.w;
					  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
					  c_3.xyz = c_8.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_6;
					  tmpvar_6[0] = unity_WorldToObject[0].xyz;
					  tmpvar_6[1] = unity_WorldToObject[1].xyz;
					  tmpvar_6[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = tmpvar_3;
					  xlv_TEXCOORD6 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 tmpvar_22;
					  tmpvar_22 = (tmpvar_2 * tmpvar_1);
					  tmpvar_2 = tmpvar_22;
					  lowp vec4 c_23;
					  lowp vec4 c_24;
					  lowp float diff_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_25 = tmpvar_26;
					  c_24.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_25);
					  c_24.w = tmpvar_9.w;
					  c_23.w = c_24.w;
					  c_23.xyz = c_24.xyz;
					  c_4.xyz = c_23.xyz;
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_6;
					  tmpvar_6[0] = unity_WorldToObject[0].xyz;
					  tmpvar_6[1] = unity_WorldToObject[1].xyz;
					  tmpvar_6[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = tmpvar_3;
					  xlv_TEXCOORD6 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 tmpvar_22;
					  tmpvar_22 = (tmpvar_2 * tmpvar_1);
					  tmpvar_2 = tmpvar_22;
					  lowp vec4 c_23;
					  lowp vec4 c_24;
					  lowp float diff_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_25 = tmpvar_26;
					  c_24.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_25);
					  c_24.w = tmpvar_9.w;
					  c_23.w = c_24.w;
					  c_23.xyz = c_24.xyz;
					  c_4.xyz = c_23.xyz;
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_6;
					  tmpvar_6[0] = unity_WorldToObject[0].xyz;
					  tmpvar_6[1] = unity_WorldToObject[1].xyz;
					  tmpvar_6[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = tmpvar_3;
					  xlv_TEXCOORD6 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 tmpvar_22;
					  tmpvar_22 = (tmpvar_2 * tmpvar_1);
					  tmpvar_2 = tmpvar_22;
					  lowp vec4 c_23;
					  lowp vec4 c_24;
					  lowp float diff_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_25 = tmpvar_26;
					  c_24.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_25);
					  c_24.w = tmpvar_9.w;
					  c_23.w = c_24.w;
					  c_23.xyz = c_24.xyz;
					  c_4.xyz = c_23.xyz;
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_1 = tmpvar_9;
					  tmpvar_2 = worldNormal_1;
					  highp vec3 lightColor0_10;
					  lightColor0_10 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_11;
					  lightColor1_11 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_12;
					  lightColor2_12 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_13;
					  lightColor3_13 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_14;
					  lightAttenSq_14 = unity_4LightAtten0;
					  highp vec3 normal_15;
					  normal_15 = worldNormal_1;
					  highp vec3 col_16;
					  highp vec4 ndotl_17;
					  highp vec4 lengthSq_18;
					  highp vec4 tmpvar_19;
					  tmpvar_19 = (unity_4LightPosX0 - tmpvar_7.x);
					  highp vec4 tmpvar_20;
					  tmpvar_20 = (unity_4LightPosY0 - tmpvar_7.y);
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (unity_4LightPosZ0 - tmpvar_7.z);
					  lengthSq_18 = (tmpvar_19 * tmpvar_19);
					  lengthSq_18 = (lengthSq_18 + (tmpvar_20 * tmpvar_20));
					  lengthSq_18 = (lengthSq_18 + (tmpvar_21 * tmpvar_21));
					  highp vec4 tmpvar_22;
					  tmpvar_22 = max (lengthSq_18, vec4(1e-06, 1e-06, 1e-06, 1e-06));
					  lengthSq_18 = tmpvar_22;
					  ndotl_17 = (tmpvar_19 * normal_15.x);
					  ndotl_17 = (ndotl_17 + (tmpvar_20 * normal_15.y));
					  ndotl_17 = (ndotl_17 + (tmpvar_21 * normal_15.z));
					  highp vec4 tmpvar_23;
					  tmpvar_23 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_17 * inversesqrt(tmpvar_22)));
					  ndotl_17 = tmpvar_23;
					  highp vec4 tmpvar_24;
					  tmpvar_24 = (tmpvar_23 * (1.0/((1.0 + 
					    (tmpvar_22 * lightAttenSq_14)
					  ))));
					  col_16 = (lightColor0_10 * tmpvar_24.x);
					  col_16 = (col_16 + (lightColor1_11 * tmpvar_24.y));
					  col_16 = (col_16 + (lightColor2_12 * tmpvar_24.z));
					  col_16 = (col_16 + (lightColor3_13 * tmpvar_24.w));
					  tmpvar_3 = col_16;
					  mediump vec3 normal_25;
					  normal_25 = worldNormal_1;
					  mediump vec3 ambient_26;
					  mediump vec3 x1_27;
					  mediump vec4 tmpvar_28;
					  tmpvar_28 = (normal_25.xyzz * normal_25.yzzx);
					  x1_27.x = dot (unity_SHBr, tmpvar_28);
					  x1_27.y = dot (unity_SHBg, tmpvar_28);
					  x1_27.z = dot (unity_SHBb, tmpvar_28);
					  ambient_26 = ((tmpvar_3 * (
					    (tmpvar_3 * ((tmpvar_3 * 0.305306) + 0.6821711))
					   + 0.01252288)) + (x1_27 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  tmpvar_3 = ambient_26;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_7;
					  xlv_TEXCOORD3 = ambient_26;
					  xlv_TEXCOORD4 = tmpvar_4;
					  xlv_TEXCOORD6 = tmpvar_5;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 normalWorld_22;
					  normalWorld_22 = tmpvar_6;
					  mediump vec3 tmpvar_23;
					  tmpvar_23 = (tmpvar_2 * tmpvar_1);
					  mediump vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalWorld_22;
					  mediump vec3 x_25;
					  x_25.x = dot (unity_SHAr, tmpvar_24);
					  x_25.y = dot (unity_SHAg, tmpvar_24);
					  x_25.z = dot (unity_SHAb, tmpvar_24);
					  mediump vec3 tmpvar_26;
					  tmpvar_26 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_2 = tmpvar_23;
					  lowp vec4 c_27;
					  lowp vec4 c_28;
					  lowp float diff_29;
					  mediump float tmpvar_30;
					  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_29 = tmpvar_30;
					  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
					  c_28.w = tmpvar_9.w;
					  c_27.w = c_28.w;
					  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
					  c_4.xyz = c_27.xyz;
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_1 = tmpvar_9;
					  tmpvar_2 = worldNormal_1;
					  highp vec3 lightColor0_10;
					  lightColor0_10 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_11;
					  lightColor1_11 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_12;
					  lightColor2_12 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_13;
					  lightColor3_13 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_14;
					  lightAttenSq_14 = unity_4LightAtten0;
					  highp vec3 normal_15;
					  normal_15 = worldNormal_1;
					  highp vec3 col_16;
					  highp vec4 ndotl_17;
					  highp vec4 lengthSq_18;
					  highp vec4 tmpvar_19;
					  tmpvar_19 = (unity_4LightPosX0 - tmpvar_7.x);
					  highp vec4 tmpvar_20;
					  tmpvar_20 = (unity_4LightPosY0 - tmpvar_7.y);
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (unity_4LightPosZ0 - tmpvar_7.z);
					  lengthSq_18 = (tmpvar_19 * tmpvar_19);
					  lengthSq_18 = (lengthSq_18 + (tmpvar_20 * tmpvar_20));
					  lengthSq_18 = (lengthSq_18 + (tmpvar_21 * tmpvar_21));
					  highp vec4 tmpvar_22;
					  tmpvar_22 = max (lengthSq_18, vec4(1e-06, 1e-06, 1e-06, 1e-06));
					  lengthSq_18 = tmpvar_22;
					  ndotl_17 = (tmpvar_19 * normal_15.x);
					  ndotl_17 = (ndotl_17 + (tmpvar_20 * normal_15.y));
					  ndotl_17 = (ndotl_17 + (tmpvar_21 * normal_15.z));
					  highp vec4 tmpvar_23;
					  tmpvar_23 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_17 * inversesqrt(tmpvar_22)));
					  ndotl_17 = tmpvar_23;
					  highp vec4 tmpvar_24;
					  tmpvar_24 = (tmpvar_23 * (1.0/((1.0 + 
					    (tmpvar_22 * lightAttenSq_14)
					  ))));
					  col_16 = (lightColor0_10 * tmpvar_24.x);
					  col_16 = (col_16 + (lightColor1_11 * tmpvar_24.y));
					  col_16 = (col_16 + (lightColor2_12 * tmpvar_24.z));
					  col_16 = (col_16 + (lightColor3_13 * tmpvar_24.w));
					  tmpvar_3 = col_16;
					  mediump vec3 normal_25;
					  normal_25 = worldNormal_1;
					  mediump vec3 ambient_26;
					  mediump vec3 x1_27;
					  mediump vec4 tmpvar_28;
					  tmpvar_28 = (normal_25.xyzz * normal_25.yzzx);
					  x1_27.x = dot (unity_SHBr, tmpvar_28);
					  x1_27.y = dot (unity_SHBg, tmpvar_28);
					  x1_27.z = dot (unity_SHBb, tmpvar_28);
					  ambient_26 = ((tmpvar_3 * (
					    (tmpvar_3 * ((tmpvar_3 * 0.305306) + 0.6821711))
					   + 0.01252288)) + (x1_27 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  tmpvar_3 = ambient_26;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_7;
					  xlv_TEXCOORD3 = ambient_26;
					  xlv_TEXCOORD4 = tmpvar_4;
					  xlv_TEXCOORD6 = tmpvar_5;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 normalWorld_22;
					  normalWorld_22 = tmpvar_6;
					  mediump vec3 tmpvar_23;
					  tmpvar_23 = (tmpvar_2 * tmpvar_1);
					  mediump vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalWorld_22;
					  mediump vec3 x_25;
					  x_25.x = dot (unity_SHAr, tmpvar_24);
					  x_25.y = dot (unity_SHAg, tmpvar_24);
					  x_25.z = dot (unity_SHAb, tmpvar_24);
					  mediump vec3 tmpvar_26;
					  tmpvar_26 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_2 = tmpvar_23;
					  lowp vec4 c_27;
					  lowp vec4 c_28;
					  lowp float diff_29;
					  mediump float tmpvar_30;
					  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_29 = tmpvar_30;
					  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
					  c_28.w = tmpvar_9.w;
					  c_27.w = c_28.w;
					  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
					  c_4.xyz = c_27.xyz;
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_1 = tmpvar_9;
					  tmpvar_2 = worldNormal_1;
					  highp vec3 lightColor0_10;
					  lightColor0_10 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_11;
					  lightColor1_11 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_12;
					  lightColor2_12 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_13;
					  lightColor3_13 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_14;
					  lightAttenSq_14 = unity_4LightAtten0;
					  highp vec3 normal_15;
					  normal_15 = worldNormal_1;
					  highp vec3 col_16;
					  highp vec4 ndotl_17;
					  highp vec4 lengthSq_18;
					  highp vec4 tmpvar_19;
					  tmpvar_19 = (unity_4LightPosX0 - tmpvar_7.x);
					  highp vec4 tmpvar_20;
					  tmpvar_20 = (unity_4LightPosY0 - tmpvar_7.y);
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (unity_4LightPosZ0 - tmpvar_7.z);
					  lengthSq_18 = (tmpvar_19 * tmpvar_19);
					  lengthSq_18 = (lengthSq_18 + (tmpvar_20 * tmpvar_20));
					  lengthSq_18 = (lengthSq_18 + (tmpvar_21 * tmpvar_21));
					  highp vec4 tmpvar_22;
					  tmpvar_22 = max (lengthSq_18, vec4(1e-06, 1e-06, 1e-06, 1e-06));
					  lengthSq_18 = tmpvar_22;
					  ndotl_17 = (tmpvar_19 * normal_15.x);
					  ndotl_17 = (ndotl_17 + (tmpvar_20 * normal_15.y));
					  ndotl_17 = (ndotl_17 + (tmpvar_21 * normal_15.z));
					  highp vec4 tmpvar_23;
					  tmpvar_23 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_17 * inversesqrt(tmpvar_22)));
					  ndotl_17 = tmpvar_23;
					  highp vec4 tmpvar_24;
					  tmpvar_24 = (tmpvar_23 * (1.0/((1.0 + 
					    (tmpvar_22 * lightAttenSq_14)
					  ))));
					  col_16 = (lightColor0_10 * tmpvar_24.x);
					  col_16 = (col_16 + (lightColor1_11 * tmpvar_24.y));
					  col_16 = (col_16 + (lightColor2_12 * tmpvar_24.z));
					  col_16 = (col_16 + (lightColor3_13 * tmpvar_24.w));
					  tmpvar_3 = col_16;
					  mediump vec3 normal_25;
					  normal_25 = worldNormal_1;
					  mediump vec3 ambient_26;
					  mediump vec3 x1_27;
					  mediump vec4 tmpvar_28;
					  tmpvar_28 = (normal_25.xyzz * normal_25.yzzx);
					  x1_27.x = dot (unity_SHBr, tmpvar_28);
					  x1_27.y = dot (unity_SHBg, tmpvar_28);
					  x1_27.z = dot (unity_SHBb, tmpvar_28);
					  ambient_26 = ((tmpvar_3 * (
					    (tmpvar_3 * ((tmpvar_3 * 0.305306) + 0.6821711))
					   + 0.01252288)) + (x1_27 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  tmpvar_3 = ambient_26;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_7;
					  xlv_TEXCOORD3 = ambient_26;
					  xlv_TEXCOORD4 = tmpvar_4;
					  xlv_TEXCOORD6 = tmpvar_5;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 normalWorld_22;
					  normalWorld_22 = tmpvar_6;
					  mediump vec3 tmpvar_23;
					  tmpvar_23 = (tmpvar_2 * tmpvar_1);
					  mediump vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalWorld_22;
					  mediump vec3 x_25;
					  x_25.x = dot (unity_SHAr, tmpvar_24);
					  x_25.y = dot (unity_SHAg, tmpvar_24);
					  x_25.z = dot (unity_SHAb, tmpvar_24);
					  mediump vec3 tmpvar_26;
					  tmpvar_26 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_2 = tmpvar_23;
					  lowp vec4 c_27;
					  lowp vec4 c_28;
					  lowp float diff_29;
					  mediump float tmpvar_30;
					  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_29 = tmpvar_30;
					  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
					  c_28.w = tmpvar_9.w;
					  c_27.w = c_28.w;
					  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
					  c_4.xyz = c_27.xyz;
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD5;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD5;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp float diff_9;
					  mediump float tmpvar_10;
					  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_9 = tmpvar_10;
					  c_8.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_9);
					  c_8.w = tmpvar_7.w;
					  highp float tmpvar_11;
					  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_11));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD5;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD5;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp float diff_9;
					  mediump float tmpvar_10;
					  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_9 = tmpvar_10;
					  c_8.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_9);
					  c_8.w = tmpvar_7.w;
					  highp float tmpvar_11;
					  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_11));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD5;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD5;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp float diff_9;
					  mediump float tmpvar_10;
					  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_9 = tmpvar_10;
					  c_8.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_9);
					  c_8.w = tmpvar_7.w;
					  highp float tmpvar_11;
					  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_11));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD5;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_13);
					  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD5;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  lowp float diff_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_10 = tmpvar_11;
					  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
					  c_9.w = tmpvar_7.w;
					  c_8.w = c_9.w;
					  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
					  highp float tmpvar_12;
					  tmpvar_12 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD5;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_13);
					  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD5;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  lowp float diff_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_10 = tmpvar_11;
					  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
					  c_9.w = tmpvar_7.w;
					  c_8.w = c_9.w;
					  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
					  highp float tmpvar_12;
					  tmpvar_12 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD5;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_13);
					  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD5;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  lowp float diff_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_10 = tmpvar_11;
					  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
					  c_9.w = tmpvar_7.w;
					  c_8.w = c_9.w;
					  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
					  highp float tmpvar_12;
					  tmpvar_12 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = tmpvar_3;
					  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
					  xlv_TEXCOORD6 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 tmpvar_22;
					  tmpvar_22 = (tmpvar_2 * tmpvar_1);
					  tmpvar_2 = tmpvar_22;
					  lowp vec4 c_23;
					  lowp float diff_24;
					  mediump float tmpvar_25;
					  tmpvar_25 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_24 = tmpvar_25;
					  c_23.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_24);
					  c_23.w = tmpvar_9.w;
					  highp float tmpvar_26;
					  tmpvar_26 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_23.xyz, vec3(tmpvar_26));
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = tmpvar_3;
					  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
					  xlv_TEXCOORD6 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 tmpvar_22;
					  tmpvar_22 = (tmpvar_2 * tmpvar_1);
					  tmpvar_2 = tmpvar_22;
					  lowp vec4 c_23;
					  lowp float diff_24;
					  mediump float tmpvar_25;
					  tmpvar_25 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_24 = tmpvar_25;
					  c_23.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_24);
					  c_23.w = tmpvar_9.w;
					  highp float tmpvar_26;
					  tmpvar_26 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_23.xyz, vec3(tmpvar_26));
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = tmpvar_3;
					  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
					  xlv_TEXCOORD6 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 tmpvar_22;
					  tmpvar_22 = (tmpvar_2 * tmpvar_1);
					  tmpvar_2 = tmpvar_22;
					  lowp vec4 c_23;
					  lowp float diff_24;
					  mediump float tmpvar_25;
					  tmpvar_25 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_24 = tmpvar_25;
					  c_23.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_24);
					  c_23.w = tmpvar_9.w;
					  highp float tmpvar_26;
					  tmpvar_26 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_23.xyz, vec3(tmpvar_26));
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  mediump vec3 normal_9;
					  normal_9 = worldNormal_1;
					  mediump vec3 x1_10;
					  mediump vec4 tmpvar_11;
					  tmpvar_11 = (normal_9.xyzz * normal_9.yzzx);
					  x1_10.x = dot (unity_SHBr, tmpvar_11);
					  x1_10.y = dot (unity_SHBg, tmpvar_11);
					  x1_10.z = dot (unity_SHBb, tmpvar_11);
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = (x1_10 + (unity_SHC.xyz * (
					    (normal_9.x * normal_9.x)
					   - 
					    (normal_9.y * normal_9.y)
					  )));
					  xlv_TEXCOORD4 = tmpvar_3;
					  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
					  xlv_TEXCOORD6 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 normalWorld_22;
					  normalWorld_22 = tmpvar_6;
					  mediump vec3 tmpvar_23;
					  tmpvar_23 = (tmpvar_2 * tmpvar_1);
					  mediump vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalWorld_22;
					  mediump vec3 x_25;
					  x_25.x = dot (unity_SHAr, tmpvar_24);
					  x_25.y = dot (unity_SHAg, tmpvar_24);
					  x_25.z = dot (unity_SHAb, tmpvar_24);
					  mediump vec3 tmpvar_26;
					  tmpvar_26 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_2 = tmpvar_23;
					  lowp vec4 c_27;
					  lowp vec4 c_28;
					  lowp float diff_29;
					  mediump float tmpvar_30;
					  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_29 = tmpvar_30;
					  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
					  c_28.w = tmpvar_9.w;
					  c_27.w = c_28.w;
					  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
					  highp float tmpvar_31;
					  tmpvar_31 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_27.xyz, vec3(tmpvar_31));
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  mediump vec3 normal_9;
					  normal_9 = worldNormal_1;
					  mediump vec3 x1_10;
					  mediump vec4 tmpvar_11;
					  tmpvar_11 = (normal_9.xyzz * normal_9.yzzx);
					  x1_10.x = dot (unity_SHBr, tmpvar_11);
					  x1_10.y = dot (unity_SHBg, tmpvar_11);
					  x1_10.z = dot (unity_SHBb, tmpvar_11);
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = (x1_10 + (unity_SHC.xyz * (
					    (normal_9.x * normal_9.x)
					   - 
					    (normal_9.y * normal_9.y)
					  )));
					  xlv_TEXCOORD4 = tmpvar_3;
					  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
					  xlv_TEXCOORD6 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 normalWorld_22;
					  normalWorld_22 = tmpvar_6;
					  mediump vec3 tmpvar_23;
					  tmpvar_23 = (tmpvar_2 * tmpvar_1);
					  mediump vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalWorld_22;
					  mediump vec3 x_25;
					  x_25.x = dot (unity_SHAr, tmpvar_24);
					  x_25.y = dot (unity_SHAg, tmpvar_24);
					  x_25.z = dot (unity_SHAb, tmpvar_24);
					  mediump vec3 tmpvar_26;
					  tmpvar_26 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_2 = tmpvar_23;
					  lowp vec4 c_27;
					  lowp vec4 c_28;
					  lowp float diff_29;
					  mediump float tmpvar_30;
					  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_29 = tmpvar_30;
					  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
					  c_28.w = tmpvar_9.w;
					  c_27.w = c_28.w;
					  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
					  highp float tmpvar_31;
					  tmpvar_31 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_27.xyz, vec3(tmpvar_31));
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  mediump vec3 normal_9;
					  normal_9 = worldNormal_1;
					  mediump vec3 x1_10;
					  mediump vec4 tmpvar_11;
					  tmpvar_11 = (normal_9.xyzz * normal_9.yzzx);
					  x1_10.x = dot (unity_SHBr, tmpvar_11);
					  x1_10.y = dot (unity_SHBg, tmpvar_11);
					  x1_10.z = dot (unity_SHBb, tmpvar_11);
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = (x1_10 + (unity_SHC.xyz * (
					    (normal_9.x * normal_9.x)
					   - 
					    (normal_9.y * normal_9.y)
					  )));
					  xlv_TEXCOORD4 = tmpvar_3;
					  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
					  xlv_TEXCOORD6 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 normalWorld_22;
					  normalWorld_22 = tmpvar_6;
					  mediump vec3 tmpvar_23;
					  tmpvar_23 = (tmpvar_2 * tmpvar_1);
					  mediump vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalWorld_22;
					  mediump vec3 x_25;
					  x_25.x = dot (unity_SHAr, tmpvar_24);
					  x_25.y = dot (unity_SHAg, tmpvar_24);
					  x_25.z = dot (unity_SHAb, tmpvar_24);
					  mediump vec3 tmpvar_26;
					  tmpvar_26 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_2 = tmpvar_23;
					  lowp vec4 c_27;
					  lowp vec4 c_28;
					  lowp float diff_29;
					  mediump float tmpvar_30;
					  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_29 = tmpvar_30;
					  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
					  c_28.w = tmpvar_9.w;
					  c_27.w = c_28.w;
					  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
					  highp float tmpvar_31;
					  tmpvar_31 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_27.xyz, vec3(tmpvar_31));
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD5;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD5;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp float diff_9;
					  mediump float tmpvar_10;
					  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_9 = tmpvar_10;
					  c_8.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_9);
					  c_8.w = tmpvar_7.w;
					  highp float tmpvar_11;
					  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_11));
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD5;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD5;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp float diff_9;
					  mediump float tmpvar_10;
					  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_9 = tmpvar_10;
					  c_8.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_9);
					  c_8.w = tmpvar_7.w;
					  highp float tmpvar_11;
					  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_11));
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD5;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD5;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp float diff_9;
					  mediump float tmpvar_10;
					  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_9 = tmpvar_10;
					  c_8.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_9);
					  c_8.w = tmpvar_7.w;
					  highp float tmpvar_11;
					  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_11));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD5;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_6;
					  xlv_TEXCOORD3 = ambient_25;
					  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD5;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  lowp float diff_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_10 = tmpvar_11;
					  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
					  c_9.w = tmpvar_7.w;
					  c_8.w = c_9.w;
					  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
					  highp float tmpvar_12;
					  tmpvar_12 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD5;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_6;
					  xlv_TEXCOORD3 = ambient_25;
					  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD5;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  lowp float diff_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_10 = tmpvar_11;
					  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
					  c_9.w = tmpvar_7.w;
					  c_8.w = c_9.w;
					  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
					  highp float tmpvar_12;
					  tmpvar_12 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD5;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_6;
					  xlv_TEXCOORD3 = ambient_25;
					  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD5;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  lowp float diff_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_10 = tmpvar_11;
					  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
					  c_9.w = tmpvar_7.w;
					  c_8.w = c_9.w;
					  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
					  highp float tmpvar_12;
					  tmpvar_12 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = tmpvar_3;
					  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
					  xlv_TEXCOORD6 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 tmpvar_22;
					  tmpvar_22 = (tmpvar_2 * tmpvar_1);
					  tmpvar_2 = tmpvar_22;
					  lowp vec4 c_23;
					  lowp float diff_24;
					  mediump float tmpvar_25;
					  tmpvar_25 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_24 = tmpvar_25;
					  c_23.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_24);
					  c_23.w = tmpvar_9.w;
					  highp float tmpvar_26;
					  tmpvar_26 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_23.xyz, vec3(tmpvar_26));
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = tmpvar_3;
					  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
					  xlv_TEXCOORD6 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 tmpvar_22;
					  tmpvar_22 = (tmpvar_2 * tmpvar_1);
					  tmpvar_2 = tmpvar_22;
					  lowp vec4 c_23;
					  lowp float diff_24;
					  mediump float tmpvar_25;
					  tmpvar_25 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_24 = tmpvar_25;
					  c_23.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_24);
					  c_23.w = tmpvar_9.w;
					  highp float tmpvar_26;
					  tmpvar_26 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_23.xyz, vec3(tmpvar_26));
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = tmpvar_3;
					  xlv_TEXCOORD5 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
					  xlv_TEXCOORD6 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 tmpvar_22;
					  tmpvar_22 = (tmpvar_2 * tmpvar_1);
					  tmpvar_2 = tmpvar_22;
					  lowp vec4 c_23;
					  lowp float diff_24;
					  mediump float tmpvar_25;
					  tmpvar_25 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_24 = tmpvar_25;
					  c_23.xyz = ((tmpvar_9.xyz * tmpvar_22) * diff_24);
					  c_23.w = tmpvar_9.w;
					  highp float tmpvar_26;
					  tmpvar_26 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_23.xyz, vec3(tmpvar_26));
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = _glesVertex.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
					  worldNormal_1 = tmpvar_10;
					  tmpvar_2 = worldNormal_1;
					  highp vec3 lightColor0_11;
					  lightColor0_11 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_12;
					  lightColor1_12 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_13;
					  lightColor2_13 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_14;
					  lightColor3_14 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_15;
					  lightAttenSq_15 = unity_4LightAtten0;
					  highp vec3 normal_16;
					  normal_16 = worldNormal_1;
					  highp vec3 col_17;
					  highp vec4 ndotl_18;
					  highp vec4 lengthSq_19;
					  highp vec4 tmpvar_20;
					  tmpvar_20 = (unity_4LightPosX0 - tmpvar_8.x);
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (unity_4LightPosY0 - tmpvar_8.y);
					  highp vec4 tmpvar_22;
					  tmpvar_22 = (unity_4LightPosZ0 - tmpvar_8.z);
					  lengthSq_19 = (tmpvar_20 * tmpvar_20);
					  lengthSq_19 = (lengthSq_19 + (tmpvar_21 * tmpvar_21));
					  lengthSq_19 = (lengthSq_19 + (tmpvar_22 * tmpvar_22));
					  highp vec4 tmpvar_23;
					  tmpvar_23 = max (lengthSq_19, vec4(1e-06, 1e-06, 1e-06, 1e-06));
					  lengthSq_19 = tmpvar_23;
					  ndotl_18 = (tmpvar_20 * normal_16.x);
					  ndotl_18 = (ndotl_18 + (tmpvar_21 * normal_16.y));
					  ndotl_18 = (ndotl_18 + (tmpvar_22 * normal_16.z));
					  highp vec4 tmpvar_24;
					  tmpvar_24 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_18 * inversesqrt(tmpvar_23)));
					  ndotl_18 = tmpvar_24;
					  highp vec4 tmpvar_25;
					  tmpvar_25 = (tmpvar_24 * (1.0/((1.0 + 
					    (tmpvar_23 * lightAttenSq_15)
					  ))));
					  col_17 = (lightColor0_11 * tmpvar_25.x);
					  col_17 = (col_17 + (lightColor1_12 * tmpvar_25.y));
					  col_17 = (col_17 + (lightColor2_13 * tmpvar_25.z));
					  col_17 = (col_17 + (lightColor3_14 * tmpvar_25.w));
					  tmpvar_3 = col_17;
					  mediump vec3 normal_26;
					  normal_26 = worldNormal_1;
					  mediump vec3 ambient_27;
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_26.xyzz * normal_26.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  ambient_27 = ((tmpvar_3 * (
					    (tmpvar_3 * ((tmpvar_3 * 0.305306) + 0.6821711))
					   + 0.01252288)) + (x1_28 + (unity_SHC.xyz * 
					    ((normal_26.x * normal_26.x) - (normal_26.y * normal_26.y))
					  )));
					  tmpvar_3 = ambient_27;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_8;
					  xlv_TEXCOORD3 = ambient_27;
					  xlv_TEXCOORD4 = tmpvar_4;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					  xlv_TEXCOORD6 = tmpvar_5;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 normalWorld_22;
					  normalWorld_22 = tmpvar_6;
					  mediump vec3 tmpvar_23;
					  tmpvar_23 = (tmpvar_2 * tmpvar_1);
					  mediump vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalWorld_22;
					  mediump vec3 x_25;
					  x_25.x = dot (unity_SHAr, tmpvar_24);
					  x_25.y = dot (unity_SHAg, tmpvar_24);
					  x_25.z = dot (unity_SHAb, tmpvar_24);
					  mediump vec3 tmpvar_26;
					  tmpvar_26 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_2 = tmpvar_23;
					  lowp vec4 c_27;
					  lowp vec4 c_28;
					  lowp float diff_29;
					  mediump float tmpvar_30;
					  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_29 = tmpvar_30;
					  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
					  c_28.w = tmpvar_9.w;
					  c_27.w = c_28.w;
					  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
					  highp float tmpvar_31;
					  tmpvar_31 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_27.xyz, vec3(tmpvar_31));
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = _glesVertex.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
					  worldNormal_1 = tmpvar_10;
					  tmpvar_2 = worldNormal_1;
					  highp vec3 lightColor0_11;
					  lightColor0_11 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_12;
					  lightColor1_12 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_13;
					  lightColor2_13 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_14;
					  lightColor3_14 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_15;
					  lightAttenSq_15 = unity_4LightAtten0;
					  highp vec3 normal_16;
					  normal_16 = worldNormal_1;
					  highp vec3 col_17;
					  highp vec4 ndotl_18;
					  highp vec4 lengthSq_19;
					  highp vec4 tmpvar_20;
					  tmpvar_20 = (unity_4LightPosX0 - tmpvar_8.x);
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (unity_4LightPosY0 - tmpvar_8.y);
					  highp vec4 tmpvar_22;
					  tmpvar_22 = (unity_4LightPosZ0 - tmpvar_8.z);
					  lengthSq_19 = (tmpvar_20 * tmpvar_20);
					  lengthSq_19 = (lengthSq_19 + (tmpvar_21 * tmpvar_21));
					  lengthSq_19 = (lengthSq_19 + (tmpvar_22 * tmpvar_22));
					  highp vec4 tmpvar_23;
					  tmpvar_23 = max (lengthSq_19, vec4(1e-06, 1e-06, 1e-06, 1e-06));
					  lengthSq_19 = tmpvar_23;
					  ndotl_18 = (tmpvar_20 * normal_16.x);
					  ndotl_18 = (ndotl_18 + (tmpvar_21 * normal_16.y));
					  ndotl_18 = (ndotl_18 + (tmpvar_22 * normal_16.z));
					  highp vec4 tmpvar_24;
					  tmpvar_24 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_18 * inversesqrt(tmpvar_23)));
					  ndotl_18 = tmpvar_24;
					  highp vec4 tmpvar_25;
					  tmpvar_25 = (tmpvar_24 * (1.0/((1.0 + 
					    (tmpvar_23 * lightAttenSq_15)
					  ))));
					  col_17 = (lightColor0_11 * tmpvar_25.x);
					  col_17 = (col_17 + (lightColor1_12 * tmpvar_25.y));
					  col_17 = (col_17 + (lightColor2_13 * tmpvar_25.z));
					  col_17 = (col_17 + (lightColor3_14 * tmpvar_25.w));
					  tmpvar_3 = col_17;
					  mediump vec3 normal_26;
					  normal_26 = worldNormal_1;
					  mediump vec3 ambient_27;
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_26.xyzz * normal_26.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  ambient_27 = ((tmpvar_3 * (
					    (tmpvar_3 * ((tmpvar_3 * 0.305306) + 0.6821711))
					   + 0.01252288)) + (x1_28 + (unity_SHC.xyz * 
					    ((normal_26.x * normal_26.x) - (normal_26.y * normal_26.y))
					  )));
					  tmpvar_3 = ambient_27;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_8;
					  xlv_TEXCOORD3 = ambient_27;
					  xlv_TEXCOORD4 = tmpvar_4;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					  xlv_TEXCOORD6 = tmpvar_5;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 normalWorld_22;
					  normalWorld_22 = tmpvar_6;
					  mediump vec3 tmpvar_23;
					  tmpvar_23 = (tmpvar_2 * tmpvar_1);
					  mediump vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalWorld_22;
					  mediump vec3 x_25;
					  x_25.x = dot (unity_SHAr, tmpvar_24);
					  x_25.y = dot (unity_SHAg, tmpvar_24);
					  x_25.z = dot (unity_SHAb, tmpvar_24);
					  mediump vec3 tmpvar_26;
					  tmpvar_26 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_2 = tmpvar_23;
					  lowp vec4 c_27;
					  lowp vec4 c_28;
					  lowp float diff_29;
					  mediump float tmpvar_30;
					  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_29 = tmpvar_30;
					  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
					  c_28.w = tmpvar_9.w;
					  c_27.w = c_28.w;
					  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
					  highp float tmpvar_31;
					  tmpvar_31 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_27.xyz, vec3(tmpvar_31));
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					varying highp vec4 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = _glesVertex.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
					  worldNormal_1 = tmpvar_10;
					  tmpvar_2 = worldNormal_1;
					  highp vec3 lightColor0_11;
					  lightColor0_11 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_12;
					  lightColor1_12 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_13;
					  lightColor2_13 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_14;
					  lightColor3_14 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_15;
					  lightAttenSq_15 = unity_4LightAtten0;
					  highp vec3 normal_16;
					  normal_16 = worldNormal_1;
					  highp vec3 col_17;
					  highp vec4 ndotl_18;
					  highp vec4 lengthSq_19;
					  highp vec4 tmpvar_20;
					  tmpvar_20 = (unity_4LightPosX0 - tmpvar_8.x);
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (unity_4LightPosY0 - tmpvar_8.y);
					  highp vec4 tmpvar_22;
					  tmpvar_22 = (unity_4LightPosZ0 - tmpvar_8.z);
					  lengthSq_19 = (tmpvar_20 * tmpvar_20);
					  lengthSq_19 = (lengthSq_19 + (tmpvar_21 * tmpvar_21));
					  lengthSq_19 = (lengthSq_19 + (tmpvar_22 * tmpvar_22));
					  highp vec4 tmpvar_23;
					  tmpvar_23 = max (lengthSq_19, vec4(1e-06, 1e-06, 1e-06, 1e-06));
					  lengthSq_19 = tmpvar_23;
					  ndotl_18 = (tmpvar_20 * normal_16.x);
					  ndotl_18 = (ndotl_18 + (tmpvar_21 * normal_16.y));
					  ndotl_18 = (ndotl_18 + (tmpvar_22 * normal_16.z));
					  highp vec4 tmpvar_24;
					  tmpvar_24 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_18 * inversesqrt(tmpvar_23)));
					  ndotl_18 = tmpvar_24;
					  highp vec4 tmpvar_25;
					  tmpvar_25 = (tmpvar_24 * (1.0/((1.0 + 
					    (tmpvar_23 * lightAttenSq_15)
					  ))));
					  col_17 = (lightColor0_11 * tmpvar_25.x);
					  col_17 = (col_17 + (lightColor1_12 * tmpvar_25.y));
					  col_17 = (col_17 + (lightColor2_13 * tmpvar_25.z));
					  col_17 = (col_17 + (lightColor3_14 * tmpvar_25.w));
					  tmpvar_3 = col_17;
					  mediump vec3 normal_26;
					  normal_26 = worldNormal_1;
					  mediump vec3 ambient_27;
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_26.xyzz * normal_26.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  ambient_27 = ((tmpvar_3 * (
					    (tmpvar_3 * ((tmpvar_3 * 0.305306) + 0.6821711))
					   + 0.01252288)) + (x1_28 + (unity_SHC.xyz * 
					    ((normal_26.x * normal_26.x) - (normal_26.y * normal_26.y))
					  )));
					  tmpvar_3 = ambient_27;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_8;
					  xlv_TEXCOORD3 = ambient_27;
					  xlv_TEXCOORD4 = tmpvar_4;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					  xlv_TEXCOORD6 = tmpvar_5;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp mat4 unity_MatrixV;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  lowp vec3 tmpvar_6;
					  lowp vec3 lightDir_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_8;
					  tmpvar_6 = xlv_TEXCOORD1;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  mediump float realtimeShadowAttenuation_10;
					  highp vec4 v_11;
					  v_11.x = unity_MatrixV[0].z;
					  v_11.y = unity_MatrixV[1].z;
					  v_11.z = unity_MatrixV[2].z;
					  v_11.w = unity_MatrixV[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (xlv_TEXCOORD2 - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((
					    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD2), v_11.xyz), sqrt(dot (tmpvar_12, tmpvar_12)), unity_ShadowFadeCenterAndType.w)
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  highp vec4 tmpvar_15;
					  tmpvar_15.w = 1.0;
					  tmpvar_15.xyz = xlv_TEXCOORD2;
					  lowp float tmpvar_16;
					  highp vec4 shadowCoord_17;
					  shadowCoord_17 = (unity_WorldToShadow[0] * tmpvar_15);
					  highp float lightShadowDataX_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = _LightShadowData.x;
					  lightShadowDataX_18 = tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, shadowCoord_17.xy).x > shadowCoord_17.z)), lightShadowDataX_18);
					  tmpvar_16 = tmpvar_20;
					  realtimeShadowAttenuation_10 = tmpvar_16;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp ((realtimeShadowAttenuation_10 + tmpvar_13), 0.0, 1.0);
					  atten_5 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_7;
					  tmpvar_1 = atten_5;
					  mediump vec3 normalWorld_22;
					  normalWorld_22 = tmpvar_6;
					  mediump vec3 tmpvar_23;
					  tmpvar_23 = (tmpvar_2 * tmpvar_1);
					  mediump vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalWorld_22;
					  mediump vec3 x_25;
					  x_25.x = dot (unity_SHAr, tmpvar_24);
					  x_25.y = dot (unity_SHAg, tmpvar_24);
					  x_25.z = dot (unity_SHAb, tmpvar_24);
					  mediump vec3 tmpvar_26;
					  tmpvar_26 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD3 + x_25)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_2 = tmpvar_23;
					  lowp vec4 c_27;
					  lowp vec4 c_28;
					  lowp float diff_29;
					  mediump float tmpvar_30;
					  tmpvar_30 = max (0.0, dot (tmpvar_6, tmpvar_3));
					  diff_29 = tmpvar_30;
					  c_28.xyz = ((tmpvar_9.xyz * tmpvar_23) * diff_29);
					  c_28.w = tmpvar_9.w;
					  c_27.w = c_28.w;
					  c_27.xyz = (c_28.xyz + (tmpvar_9.xyz * tmpvar_26));
					  highp float tmpvar_31;
					  tmpvar_31 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_27.xyz, vec3(tmpvar_31));
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
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
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
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
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES"
				}
			}
		}
		Pass {
			Name "FORWARD"
			LOD 200
			Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" }
			Blend One One, One One
			ZWrite Off
			Offset -3, -3
			GpuProgramID 121391
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
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
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_9).xyz;
					  highp float tmpvar_10;
					  tmpvar_10 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_11;
					  tmpvar_11 = texture2D (_LightTexture0, vec2(tmpvar_10)).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_11);
					  lowp vec4 c_12;
					  lowp vec4 c_13;
					  lowp float diff_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_14 = tmpvar_15;
					  c_13.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_14);
					  c_13.w = tmpvar_8.w;
					  c_12.w = c_13.w;
					  c_12.xyz = c_13.xyz;
					  c_3.xyz = c_12.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
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
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_9).xyz;
					  highp float tmpvar_10;
					  tmpvar_10 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_11;
					  tmpvar_11 = texture2D (_LightTexture0, vec2(tmpvar_10)).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_11);
					  lowp vec4 c_12;
					  lowp vec4 c_13;
					  lowp float diff_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_14 = tmpvar_15;
					  c_13.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_14);
					  c_13.w = tmpvar_8.w;
					  c_12.w = c_13.w;
					  c_12.xyz = c_13.xyz;
					  c_3.xyz = c_12.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
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
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_9).xyz;
					  highp float tmpvar_10;
					  tmpvar_10 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_11;
					  tmpvar_11 = texture2D (_LightTexture0, vec2(tmpvar_10)).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_11);
					  lowp vec4 c_12;
					  lowp vec4 c_13;
					  lowp float diff_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_14 = tmpvar_15;
					  c_13.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_14);
					  c_13.w = tmpvar_8.w;
					  c_12.w = c_13.w;
					  c_12.xyz = c_13.xyz;
					  c_3.xyz = c_12.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  lowp float diff_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_10 = tmpvar_11;
					  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
					  c_9.w = tmpvar_7.w;
					  c_8.w = c_9.w;
					  c_8.xyz = c_9.xyz;
					  c_3.xyz = c_8.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  lowp float diff_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_10 = tmpvar_11;
					  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
					  c_9.w = tmpvar_7.w;
					  c_8.w = c_9.w;
					  c_8.xyz = c_9.xyz;
					  c_3.xyz = c_8.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  lowp float diff_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_10 = tmpvar_11;
					  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
					  c_9.w = tmpvar_7.w;
					  c_8.w = c_9.w;
					  c_8.xyz = c_9.xyz;
					  c_3.xyz = c_8.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
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
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = xlv_TEXCOORD2;
					  lightCoord_5 = (unity_WorldToLight * tmpvar_10);
					  lowp vec4 tmpvar_11;
					  highp vec2 P_12;
					  P_12 = ((lightCoord_5.xy / lightCoord_5.w) + 0.5);
					  tmpvar_11 = texture2D (_LightTexture0, P_12);
					  highp float tmpvar_13;
					  tmpvar_13 = dot (lightCoord_5.xyz, lightCoord_5.xyz);
					  lowp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_LightTextureB0, vec2(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = ((float(
					    (lightCoord_5.z > 0.0)
					  ) * tmpvar_11.w) * tmpvar_14.w);
					  atten_4 = tmpvar_15;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * atten_4);
					  lowp vec4 c_16;
					  lowp vec4 c_17;
					  lowp float diff_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = max (0.0, dot (tmpvar_6, tmpvar_2));
					  diff_18 = tmpvar_19;
					  c_17.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_18);
					  c_17.w = tmpvar_9.w;
					  c_16.w = c_17.w;
					  c_16.xyz = c_17.xyz;
					  c_3.xyz = c_16.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
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
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = xlv_TEXCOORD2;
					  lightCoord_5 = (unity_WorldToLight * tmpvar_10);
					  lowp vec4 tmpvar_11;
					  highp vec2 P_12;
					  P_12 = ((lightCoord_5.xy / lightCoord_5.w) + 0.5);
					  tmpvar_11 = texture2D (_LightTexture0, P_12);
					  highp float tmpvar_13;
					  tmpvar_13 = dot (lightCoord_5.xyz, lightCoord_5.xyz);
					  lowp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_LightTextureB0, vec2(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = ((float(
					    (lightCoord_5.z > 0.0)
					  ) * tmpvar_11.w) * tmpvar_14.w);
					  atten_4 = tmpvar_15;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * atten_4);
					  lowp vec4 c_16;
					  lowp vec4 c_17;
					  lowp float diff_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = max (0.0, dot (tmpvar_6, tmpvar_2));
					  diff_18 = tmpvar_19;
					  c_17.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_18);
					  c_17.w = tmpvar_9.w;
					  c_16.w = c_17.w;
					  c_16.xyz = c_17.xyz;
					  c_3.xyz = c_16.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
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
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = xlv_TEXCOORD2;
					  lightCoord_5 = (unity_WorldToLight * tmpvar_10);
					  lowp vec4 tmpvar_11;
					  highp vec2 P_12;
					  P_12 = ((lightCoord_5.xy / lightCoord_5.w) + 0.5);
					  tmpvar_11 = texture2D (_LightTexture0, P_12);
					  highp float tmpvar_13;
					  tmpvar_13 = dot (lightCoord_5.xyz, lightCoord_5.xyz);
					  lowp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_LightTextureB0, vec2(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = ((float(
					    (lightCoord_5.z > 0.0)
					  ) * tmpvar_11.w) * tmpvar_14.w);
					  atten_4 = tmpvar_15;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * atten_4);
					  lowp vec4 c_16;
					  lowp vec4 c_17;
					  lowp float diff_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = max (0.0, dot (tmpvar_6, tmpvar_2));
					  diff_18 = tmpvar_19;
					  c_17.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_18);
					  c_17.w = tmpvar_9.w;
					  c_16.w = c_17.w;
					  c_16.xyz = c_17.xyz;
					  c_3.xyz = c_16.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
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
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_9).xyz;
					  highp float tmpvar_10;
					  tmpvar_10 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_11;
					  tmpvar_11 = (texture2D (_LightTextureB0, vec2(tmpvar_10)).w * textureCube (_LightTexture0, lightCoord_4).w);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_11);
					  lowp vec4 c_12;
					  lowp vec4 c_13;
					  lowp float diff_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_14 = tmpvar_15;
					  c_13.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_14);
					  c_13.w = tmpvar_8.w;
					  c_12.w = c_13.w;
					  c_12.xyz = c_13.xyz;
					  c_3.xyz = c_12.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
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
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_9).xyz;
					  highp float tmpvar_10;
					  tmpvar_10 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_11;
					  tmpvar_11 = (texture2D (_LightTextureB0, vec2(tmpvar_10)).w * textureCube (_LightTexture0, lightCoord_4).w);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_11);
					  lowp vec4 c_12;
					  lowp vec4 c_13;
					  lowp float diff_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_14 = tmpvar_15;
					  c_13.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_14);
					  c_13.w = tmpvar_8.w;
					  c_12.w = c_13.w;
					  c_12.xyz = c_13.xyz;
					  c_3.xyz = c_12.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
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
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_9).xyz;
					  highp float tmpvar_10;
					  tmpvar_10 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_11;
					  tmpvar_11 = (texture2D (_LightTextureB0, vec2(tmpvar_10)).w * textureCube (_LightTexture0, lightCoord_4).w);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_11);
					  lowp vec4 c_12;
					  lowp vec4 c_13;
					  lowp float diff_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_14 = tmpvar_15;
					  c_13.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_14);
					  c_13.w = tmpvar_8.w;
					  c_12.w = c_13.w;
					  c_12.xyz = c_13.xyz;
					  c_3.xyz = c_12.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
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
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_9).xy;
					  lowp float tmpvar_10;
					  tmpvar_10 = texture2D (_LightTexture0, lightCoord_4).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_10);
					  lowp vec4 c_11;
					  lowp vec4 c_12;
					  lowp float diff_13;
					  mediump float tmpvar_14;
					  tmpvar_14 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_13 = tmpvar_14;
					  c_12.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_13);
					  c_12.w = tmpvar_8.w;
					  c_11.w = c_12.w;
					  c_11.xyz = c_12.xyz;
					  c_3.xyz = c_11.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
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
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_9).xy;
					  lowp float tmpvar_10;
					  tmpvar_10 = texture2D (_LightTexture0, lightCoord_4).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_10);
					  lowp vec4 c_11;
					  lowp vec4 c_12;
					  lowp float diff_13;
					  mediump float tmpvar_14;
					  tmpvar_14 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_13 = tmpvar_14;
					  c_12.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_13);
					  c_12.w = tmpvar_8.w;
					  c_11.w = c_12.w;
					  c_11.xyz = c_12.xyz;
					  c_3.xyz = c_11.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
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
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_9).xy;
					  lowp float tmpvar_10;
					  tmpvar_10 = texture2D (_LightTexture0, lightCoord_4).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_10);
					  lowp vec4 c_11;
					  lowp vec4 c_12;
					  lowp float diff_13;
					  mediump float tmpvar_14;
					  tmpvar_14 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_13 = tmpvar_14;
					  c_12.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_13);
					  c_12.w = tmpvar_8.w;
					  c_11.w = c_12.w;
					  c_11.xyz = c_12.xyz;
					  c_3.xyz = c_11.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
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
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_9).xyz;
					  highp float tmpvar_10;
					  tmpvar_10 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_11;
					  tmpvar_11 = texture2D (_LightTexture0, vec2(tmpvar_10)).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_11);
					  lowp vec4 c_12;
					  lowp float diff_13;
					  mediump float tmpvar_14;
					  tmpvar_14 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_13 = tmpvar_14;
					  c_12.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_13);
					  c_12.w = tmpvar_8.w;
					  highp float tmpvar_15;
					  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
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
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_9).xyz;
					  highp float tmpvar_10;
					  tmpvar_10 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_11;
					  tmpvar_11 = texture2D (_LightTexture0, vec2(tmpvar_10)).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_11);
					  lowp vec4 c_12;
					  lowp float diff_13;
					  mediump float tmpvar_14;
					  tmpvar_14 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_13 = tmpvar_14;
					  c_12.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_13);
					  c_12.w = tmpvar_8.w;
					  highp float tmpvar_15;
					  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
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
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_9).xyz;
					  highp float tmpvar_10;
					  tmpvar_10 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_11;
					  tmpvar_11 = texture2D (_LightTexture0, vec2(tmpvar_10)).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_11);
					  lowp vec4 c_12;
					  lowp float diff_13;
					  mediump float tmpvar_14;
					  tmpvar_14 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_13 = tmpvar_14;
					  c_12.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_13);
					  c_12.w = tmpvar_8.w;
					  highp float tmpvar_15;
					  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp float diff_9;
					  mediump float tmpvar_10;
					  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_9 = tmpvar_10;
					  c_8.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_9);
					  c_8.w = tmpvar_7.w;
					  highp float tmpvar_11;
					  tmpvar_11 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = (c_8.xyz * vec3(tmpvar_11));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp float diff_9;
					  mediump float tmpvar_10;
					  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_9 = tmpvar_10;
					  c_8.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_9);
					  c_8.w = tmpvar_7.w;
					  highp float tmpvar_11;
					  tmpvar_11 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = (c_8.xyz * vec3(tmpvar_11));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
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
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_8;
					  lowp float diff_9;
					  mediump float tmpvar_10;
					  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_9 = tmpvar_10;
					  c_8.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_9);
					  c_8.w = tmpvar_7.w;
					  highp float tmpvar_11;
					  tmpvar_11 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = (c_8.xyz * vec3(tmpvar_11));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
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
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = xlv_TEXCOORD2;
					  lightCoord_5 = (unity_WorldToLight * tmpvar_10);
					  lowp vec4 tmpvar_11;
					  highp vec2 P_12;
					  P_12 = ((lightCoord_5.xy / lightCoord_5.w) + 0.5);
					  tmpvar_11 = texture2D (_LightTexture0, P_12);
					  highp float tmpvar_13;
					  tmpvar_13 = dot (lightCoord_5.xyz, lightCoord_5.xyz);
					  lowp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_LightTextureB0, vec2(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = ((float(
					    (lightCoord_5.z > 0.0)
					  ) * tmpvar_11.w) * tmpvar_14.w);
					  atten_4 = tmpvar_15;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * atten_4);
					  lowp vec4 c_16;
					  lowp float diff_17;
					  mediump float tmpvar_18;
					  tmpvar_18 = max (0.0, dot (tmpvar_6, tmpvar_2));
					  diff_17 = tmpvar_18;
					  c_16.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_17);
					  c_16.w = tmpvar_9.w;
					  highp float tmpvar_19;
					  tmpvar_19 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = (c_16.xyz * vec3(tmpvar_19));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
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
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = xlv_TEXCOORD2;
					  lightCoord_5 = (unity_WorldToLight * tmpvar_10);
					  lowp vec4 tmpvar_11;
					  highp vec2 P_12;
					  P_12 = ((lightCoord_5.xy / lightCoord_5.w) + 0.5);
					  tmpvar_11 = texture2D (_LightTexture0, P_12);
					  highp float tmpvar_13;
					  tmpvar_13 = dot (lightCoord_5.xyz, lightCoord_5.xyz);
					  lowp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_LightTextureB0, vec2(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = ((float(
					    (lightCoord_5.z > 0.0)
					  ) * tmpvar_11.w) * tmpvar_14.w);
					  atten_4 = tmpvar_15;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * atten_4);
					  lowp vec4 c_16;
					  lowp float diff_17;
					  mediump float tmpvar_18;
					  tmpvar_18 = max (0.0, dot (tmpvar_6, tmpvar_2));
					  diff_17 = tmpvar_18;
					  c_16.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_17);
					  c_16.w = tmpvar_9.w;
					  highp float tmpvar_19;
					  tmpvar_19 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = (c_16.xyz * vec3(tmpvar_19));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
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
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = xlv_TEXCOORD2;
					  lightCoord_5 = (unity_WorldToLight * tmpvar_10);
					  lowp vec4 tmpvar_11;
					  highp vec2 P_12;
					  P_12 = ((lightCoord_5.xy / lightCoord_5.w) + 0.5);
					  tmpvar_11 = texture2D (_LightTexture0, P_12);
					  highp float tmpvar_13;
					  tmpvar_13 = dot (lightCoord_5.xyz, lightCoord_5.xyz);
					  lowp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_LightTextureB0, vec2(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = ((float(
					    (lightCoord_5.z > 0.0)
					  ) * tmpvar_11.w) * tmpvar_14.w);
					  atten_4 = tmpvar_15;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * atten_4);
					  lowp vec4 c_16;
					  lowp float diff_17;
					  mediump float tmpvar_18;
					  tmpvar_18 = max (0.0, dot (tmpvar_6, tmpvar_2));
					  diff_17 = tmpvar_18;
					  c_16.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_17);
					  c_16.w = tmpvar_9.w;
					  highp float tmpvar_19;
					  tmpvar_19 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = (c_16.xyz * vec3(tmpvar_19));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
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
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_9).xyz;
					  highp float tmpvar_10;
					  tmpvar_10 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_11;
					  tmpvar_11 = (texture2D (_LightTextureB0, vec2(tmpvar_10)).w * textureCube (_LightTexture0, lightCoord_4).w);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_11);
					  lowp vec4 c_12;
					  lowp float diff_13;
					  mediump float tmpvar_14;
					  tmpvar_14 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_13 = tmpvar_14;
					  c_12.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_13);
					  c_12.w = tmpvar_8.w;
					  highp float tmpvar_15;
					  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
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
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_9).xyz;
					  highp float tmpvar_10;
					  tmpvar_10 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_11;
					  tmpvar_11 = (texture2D (_LightTextureB0, vec2(tmpvar_10)).w * textureCube (_LightTexture0, lightCoord_4).w);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_11);
					  lowp vec4 c_12;
					  lowp float diff_13;
					  mediump float tmpvar_14;
					  tmpvar_14 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_13 = tmpvar_14;
					  c_12.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_13);
					  c_12.w = tmpvar_8.w;
					  highp float tmpvar_15;
					  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
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
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_9).xyz;
					  highp float tmpvar_10;
					  tmpvar_10 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_11;
					  tmpvar_11 = (texture2D (_LightTextureB0, vec2(tmpvar_10)).w * textureCube (_LightTexture0, lightCoord_4).w);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_11);
					  lowp vec4 c_12;
					  lowp float diff_13;
					  mediump float tmpvar_14;
					  tmpvar_14 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_13 = tmpvar_14;
					  c_12.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_13);
					  c_12.w = tmpvar_8.w;
					  highp float tmpvar_15;
					  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
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
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_9).xy;
					  lowp float tmpvar_10;
					  tmpvar_10 = texture2D (_LightTexture0, lightCoord_4).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_10);
					  lowp vec4 c_11;
					  lowp float diff_12;
					  mediump float tmpvar_13;
					  tmpvar_13 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_12 = tmpvar_13;
					  c_11.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_12);
					  c_11.w = tmpvar_8.w;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = (c_11.xyz * vec3(tmpvar_14));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
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
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_9).xy;
					  lowp float tmpvar_10;
					  tmpvar_10 = texture2D (_LightTexture0, lightCoord_4).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_10);
					  lowp vec4 c_11;
					  lowp float diff_12;
					  mediump float tmpvar_13;
					  tmpvar_13 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_12 = tmpvar_13;
					  c_11.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_12);
					  c_11.w = tmpvar_8.w;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = (c_11.xyz * vec3(tmpvar_14));
					  c_3.w = 1.0;
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
					uniform highp vec4 _MainTex_ST;
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
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
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
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = xlv_TEXCOORD2;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_9).xy;
					  lowp float tmpvar_10;
					  tmpvar_10 = texture2D (_LightTexture0, lightCoord_4).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_10);
					  lowp vec4 c_11;
					  lowp float diff_12;
					  mediump float tmpvar_13;
					  tmpvar_13 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_12 = tmpvar_13;
					  c_11.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_12);
					  c_11.w = tmpvar_8.w;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_3.xyz = (c_11.xyz * vec3(tmpvar_14));
					  c_3.w = 1.0;
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
		Pass {
			Name "PREPASS"
			LOD 200
			Tags { "LIGHTMODE" = "PREPASSBASE" "RenderType" = "Opaque" }
			Offset -3, -3
			GpuProgramID 174358
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying mediump vec3 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
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
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD0;
					  res_1.xyz = ((tmpvar_2 * 0.5) + 0.5);
					  res_1.w = 0.0;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying mediump vec3 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
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
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD0;
					  res_1.xyz = ((tmpvar_2 * 0.5) + 0.5);
					  res_1.w = 0.0;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying mediump vec3 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
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
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD0;
					  res_1.xyz = ((tmpvar_2 * 0.5) + 0.5);
					  res_1.w = 0.0;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
			}
		}
		Pass {
			Name "PREPASS"
			LOD 200
			Tags { "LIGHTMODE" = "PREPASSFINAL" "RenderType" = "Opaque" }
			ZWrite Off
			Offset -3, -3
			GpuProgramID 212194
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
					  mediump vec4 normal_10;
					  normal_10 = tmpvar_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, normal_10);
					  x_12.y = dot (unity_SHAg, normal_10);
					  x_12.z = dot (unity_SHAb, normal_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
					  )));
					  mediump vec3 tmpvar_15;
					  tmpvar_15 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_11 = tmpvar_15;
					  tmpvar_2 = tmpvar_15;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_5;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_6;
					  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
					  c_6.w = tmpvar_4.w;
					  c_2.xyz = c_6.xyz;
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
					  mediump vec4 normal_10;
					  normal_10 = tmpvar_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, normal_10);
					  x_12.y = dot (unity_SHAg, normal_10);
					  x_12.z = dot (unity_SHAb, normal_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
					  )));
					  mediump vec3 tmpvar_15;
					  tmpvar_15 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_11 = tmpvar_15;
					  tmpvar_2 = tmpvar_15;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_5;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_6;
					  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
					  c_6.w = tmpvar_4.w;
					  c_2.xyz = c_6.xyz;
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
					  mediump vec4 normal_10;
					  normal_10 = tmpvar_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, normal_10);
					  x_12.y = dot (unity_SHAg, normal_10);
					  x_12.z = dot (unity_SHAb, normal_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
					  )));
					  mediump vec3 tmpvar_15;
					  tmpvar_15 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_11 = tmpvar_15;
					  tmpvar_2 = tmpvar_15;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_5;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_6;
					  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
					  c_6.w = tmpvar_4.w;
					  c_2.xyz = c_6.xyz;
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
					  mediump vec4 normal_10;
					  normal_10 = tmpvar_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, normal_10);
					  x_12.y = dot (unity_SHAg, normal_10);
					  x_12.z = dot (unity_SHAb, normal_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
					  )));
					  mediump vec3 tmpvar_15;
					  tmpvar_15 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_11 = tmpvar_15;
					  tmpvar_2 = tmpvar_15;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_5;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_6;
					  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
					  c_6.w = tmpvar_4.w;
					  c_2.xyz = c_6.xyz;
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
					  mediump vec4 normal_10;
					  normal_10 = tmpvar_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, normal_10);
					  x_12.y = dot (unity_SHAg, normal_10);
					  x_12.z = dot (unity_SHAb, normal_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
					  )));
					  mediump vec3 tmpvar_15;
					  tmpvar_15 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_11 = tmpvar_15;
					  tmpvar_2 = tmpvar_15;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_5;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_6;
					  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
					  c_6.w = tmpvar_4.w;
					  c_2.xyz = c_6.xyz;
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
					  mediump vec4 normal_10;
					  normal_10 = tmpvar_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, normal_10);
					  x_12.y = dot (unity_SHAg, normal_10);
					  x_12.z = dot (unity_SHAb, normal_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
					  )));
					  mediump vec3 tmpvar_15;
					  tmpvar_15 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_11 = tmpvar_15;
					  tmpvar_2 = tmpvar_15;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_5;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_6;
					  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
					  c_6.w = tmpvar_4.w;
					  c_2.xyz = c_6.xyz;
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
					  mediump vec4 normal_10;
					  normal_10 = tmpvar_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, normal_10);
					  x_12.y = dot (unity_SHAg, normal_10);
					  x_12.z = dot (unity_SHAb, normal_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
					  )));
					  mediump vec3 tmpvar_15;
					  tmpvar_15 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_11 = tmpvar_15;
					  tmpvar_2 = tmpvar_15;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_5;
					  mediump vec4 tmpvar_6;
					  tmpvar_6 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
					  light_3.w = tmpvar_6.w;
					  light_3.xyz = (tmpvar_6.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_7;
					  c_7.xyz = (tmpvar_4.xyz * light_3.xyz);
					  c_7.w = tmpvar_4.w;
					  c_2.xyz = c_7.xyz;
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
					  mediump vec4 normal_10;
					  normal_10 = tmpvar_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, normal_10);
					  x_12.y = dot (unity_SHAg, normal_10);
					  x_12.z = dot (unity_SHAb, normal_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
					  )));
					  mediump vec3 tmpvar_15;
					  tmpvar_15 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_11 = tmpvar_15;
					  tmpvar_2 = tmpvar_15;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_5;
					  mediump vec4 tmpvar_6;
					  tmpvar_6 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
					  light_3.w = tmpvar_6.w;
					  light_3.xyz = (tmpvar_6.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_7;
					  c_7.xyz = (tmpvar_4.xyz * light_3.xyz);
					  c_7.w = tmpvar_4.w;
					  c_2.xyz = c_7.xyz;
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
					  mediump vec4 normal_10;
					  normal_10 = tmpvar_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, normal_10);
					  x_12.y = dot (unity_SHAg, normal_10);
					  x_12.z = dot (unity_SHAb, normal_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
					  )));
					  mediump vec3 tmpvar_15;
					  tmpvar_15 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_11 = tmpvar_15;
					  tmpvar_2 = tmpvar_15;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_5;
					  mediump vec4 tmpvar_6;
					  tmpvar_6 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
					  light_3.w = tmpvar_6.w;
					  light_3.xyz = (tmpvar_6.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_7;
					  c_7.xyz = (tmpvar_4.xyz * light_3.xyz);
					  c_7.w = tmpvar_4.w;
					  c_2.xyz = c_7.xyz;
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
					  mediump vec4 normal_10;
					  normal_10 = tmpvar_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, normal_10);
					  x_12.y = dot (unity_SHAg, normal_10);
					  x_12.z = dot (unity_SHAb, normal_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
					  )));
					  mediump vec3 tmpvar_15;
					  tmpvar_15 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_11 = tmpvar_15;
					  tmpvar_2 = tmpvar_15;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_5;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_6;
					  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
					  c_6.w = tmpvar_4.w;
					  c_2 = c_6;
					  highp float tmpvar_7;
					  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
					  mediump vec4 normal_10;
					  normal_10 = tmpvar_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, normal_10);
					  x_12.y = dot (unity_SHAg, normal_10);
					  x_12.z = dot (unity_SHAb, normal_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
					  )));
					  mediump vec3 tmpvar_15;
					  tmpvar_15 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_11 = tmpvar_15;
					  tmpvar_2 = tmpvar_15;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_5;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_6;
					  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
					  c_6.w = tmpvar_4.w;
					  c_2 = c_6;
					  highp float tmpvar_7;
					  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
					  mediump vec4 normal_10;
					  normal_10 = tmpvar_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, normal_10);
					  x_12.y = dot (unity_SHAg, normal_10);
					  x_12.z = dot (unity_SHAb, normal_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
					  )));
					  mediump vec3 tmpvar_15;
					  tmpvar_15 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_11 = tmpvar_15;
					  tmpvar_2 = tmpvar_15;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_5;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_6;
					  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
					  c_6.w = tmpvar_4.w;
					  c_2 = c_6;
					  highp float tmpvar_7;
					  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
					  mediump vec4 normal_10;
					  normal_10 = tmpvar_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, normal_10);
					  x_12.y = dot (unity_SHAg, normal_10);
					  x_12.z = dot (unity_SHAb, normal_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
					  )));
					  mediump vec3 tmpvar_15;
					  tmpvar_15 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_11 = tmpvar_15;
					  tmpvar_2 = tmpvar_15;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_5;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_6;
					  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
					  c_6.w = tmpvar_4.w;
					  c_2 = c_6;
					  highp float tmpvar_7;
					  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
					  mediump vec4 normal_10;
					  normal_10 = tmpvar_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, normal_10);
					  x_12.y = dot (unity_SHAg, normal_10);
					  x_12.z = dot (unity_SHAb, normal_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
					  )));
					  mediump vec3 tmpvar_15;
					  tmpvar_15 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_11 = tmpvar_15;
					  tmpvar_2 = tmpvar_15;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_5;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_6;
					  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
					  c_6.w = tmpvar_4.w;
					  c_2 = c_6;
					  highp float tmpvar_7;
					  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
					  mediump vec4 normal_10;
					  normal_10 = tmpvar_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, normal_10);
					  x_12.y = dot (unity_SHAg, normal_10);
					  x_12.z = dot (unity_SHAb, normal_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
					  )));
					  mediump vec3 tmpvar_15;
					  tmpvar_15 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_11 = tmpvar_15;
					  tmpvar_2 = tmpvar_15;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_5;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_6;
					  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
					  c_6.w = tmpvar_4.w;
					  c_2 = c_6;
					  highp float tmpvar_7;
					  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
					  mediump vec4 normal_10;
					  normal_10 = tmpvar_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, normal_10);
					  x_12.y = dot (unity_SHAg, normal_10);
					  x_12.z = dot (unity_SHAb, normal_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
					  )));
					  mediump vec3 tmpvar_15;
					  tmpvar_15 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_11 = tmpvar_15;
					  tmpvar_2 = tmpvar_15;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_5;
					  mediump vec4 tmpvar_6;
					  tmpvar_6 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
					  light_3.w = tmpvar_6.w;
					  light_3.xyz = (tmpvar_6.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_7;
					  c_7.xyz = (tmpvar_4.xyz * light_3.xyz);
					  c_7.w = tmpvar_4.w;
					  c_2 = c_7;
					  highp float tmpvar_8;
					  tmpvar_8 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_8));
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
					  mediump vec4 normal_10;
					  normal_10 = tmpvar_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, normal_10);
					  x_12.y = dot (unity_SHAg, normal_10);
					  x_12.z = dot (unity_SHAb, normal_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
					  )));
					  mediump vec3 tmpvar_15;
					  tmpvar_15 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_11 = tmpvar_15;
					  tmpvar_2 = tmpvar_15;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_5;
					  mediump vec4 tmpvar_6;
					  tmpvar_6 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
					  light_3.w = tmpvar_6.w;
					  light_3.xyz = (tmpvar_6.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_7;
					  c_7.xyz = (tmpvar_4.xyz * light_3.xyz);
					  c_7.w = tmpvar_4.w;
					  c_2 = c_7;
					  highp float tmpvar_8;
					  tmpvar_8 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_8));
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normalize((_glesNormal * tmpvar_8));
					  mediump vec4 normal_10;
					  normal_10 = tmpvar_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, normal_10);
					  x_12.y = dot (unity_SHAg, normal_10);
					  x_12.z = dot (unity_SHAb, normal_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
					  )));
					  mediump vec3 tmpvar_15;
					  tmpvar_15 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_11 = tmpvar_15;
					  tmpvar_2 = tmpvar_15;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_5;
					  mediump vec4 tmpvar_6;
					  tmpvar_6 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
					  light_3.w = tmpvar_6.w;
					  light_3.xyz = (tmpvar_6.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_7;
					  c_7.xyz = (tmpvar_4.xyz * light_3.xyz);
					  c_7.w = tmpvar_4.w;
					  c_2 = c_7;
					  highp float tmpvar_8;
					  tmpvar_8 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_8));
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
					"!!GLES"
				}
			}
		}
		Pass {
			Name "DEFERRED"
			LOD 200
			Tags { "LIGHTMODE" = "DEFERRED" "RenderType" = "Opaque" }
			Offset -3, -3
			GpuProgramID 317610
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.zw = vec2(0.0, 0.0);
					  tmpvar_3.xy = vec2(0.0, 0.0);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					#extension GL_EXT_draw_buffers : enable
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec4 outEmission_1;
					  lowp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_3;
					  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz;
					  mediump vec4 emission_4;
					  mediump vec3 tmpvar_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_5 = tmpvar_3;
					  tmpvar_6 = tmpvar_2;
					  mediump vec4 tmpvar_7;
					  tmpvar_7.xyz = tmpvar_5;
					  tmpvar_7.w = 1.0;
					  mediump vec4 tmpvar_8;
					  tmpvar_8.xyz = vec3(0.0, 0.0, 0.0);
					  tmpvar_8.w = 0.0;
					  mediump vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = ((tmpvar_6 * 0.5) + 0.5);
					  lowp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
					  emission_4 = tmpvar_10;
					  emission_4.xyz = emission_4.xyz;
					  outEmission_1.w = emission_4.w;
					  outEmission_1.xyz = exp2(-(emission_4.xyz));
					  gl_FragData[0] = tmpvar_7;
					  gl_FragData[1] = tmpvar_8;
					  gl_FragData[2] = tmpvar_9;
					  gl_FragData[3] = outEmission_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.zw = vec2(0.0, 0.0);
					  tmpvar_3.xy = vec2(0.0, 0.0);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					#extension GL_EXT_draw_buffers : enable
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec4 outEmission_1;
					  lowp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_3;
					  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz;
					  mediump vec4 emission_4;
					  mediump vec3 tmpvar_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_5 = tmpvar_3;
					  tmpvar_6 = tmpvar_2;
					  mediump vec4 tmpvar_7;
					  tmpvar_7.xyz = tmpvar_5;
					  tmpvar_7.w = 1.0;
					  mediump vec4 tmpvar_8;
					  tmpvar_8.xyz = vec3(0.0, 0.0, 0.0);
					  tmpvar_8.w = 0.0;
					  mediump vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = ((tmpvar_6 * 0.5) + 0.5);
					  lowp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
					  emission_4 = tmpvar_10;
					  emission_4.xyz = emission_4.xyz;
					  outEmission_1.w = emission_4.w;
					  outEmission_1.xyz = exp2(-(emission_4.xyz));
					  gl_FragData[0] = tmpvar_7;
					  gl_FragData[1] = tmpvar_8;
					  gl_FragData[2] = tmpvar_9;
					  gl_FragData[3] = outEmission_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.zw = vec2(0.0, 0.0);
					  tmpvar_3.xy = vec2(0.0, 0.0);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					#extension GL_EXT_draw_buffers : enable
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec4 outEmission_1;
					  lowp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_3;
					  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz;
					  mediump vec4 emission_4;
					  mediump vec3 tmpvar_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_5 = tmpvar_3;
					  tmpvar_6 = tmpvar_2;
					  mediump vec4 tmpvar_7;
					  tmpvar_7.xyz = tmpvar_5;
					  tmpvar_7.w = 1.0;
					  mediump vec4 tmpvar_8;
					  tmpvar_8.xyz = vec3(0.0, 0.0, 0.0);
					  tmpvar_8.w = 0.0;
					  mediump vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = ((tmpvar_6 * 0.5) + 0.5);
					  lowp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
					  emission_4 = tmpvar_10;
					  emission_4.xyz = emission_4.xyz;
					  outEmission_1.w = emission_4.w;
					  outEmission_1.xyz = exp2(-(emission_4.xyz));
					  gl_FragData[0] = tmpvar_7;
					  gl_FragData[1] = tmpvar_8;
					  gl_FragData[2] = tmpvar_9;
					  gl_FragData[3] = outEmission_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.zw = vec2(0.0, 0.0);
					  tmpvar_3.xy = vec2(0.0, 0.0);
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
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = tmpvar_3;
					  xlv_TEXCOORD4 = max (vec3(0.0, 0.0, 0.0), tmpvar_13);
					}
					
					
					#endif
					#ifdef FRAGMENT
					#extension GL_EXT_draw_buffers : enable
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 outEmission_1;
					  lowp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_3 = tmpvar_4.xyz;
					  mediump vec4 emission_5;
					  mediump vec3 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_6 = tmpvar_3;
					  tmpvar_7 = tmpvar_2;
					  mediump vec4 tmpvar_8;
					  tmpvar_8.xyz = tmpvar_6;
					  tmpvar_8.w = 1.0;
					  mediump vec4 tmpvar_9;
					  tmpvar_9.xyz = vec3(0.0, 0.0, 0.0);
					  tmpvar_9.w = 0.0;
					  mediump vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = ((tmpvar_7 * 0.5) + 0.5);
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
					  emission_5 = tmpvar_11;
					  emission_5.xyz = (emission_5.xyz + (tmpvar_4.xyz * xlv_TEXCOORD4));
					  outEmission_1.w = emission_5.w;
					  outEmission_1.xyz = exp2(-(emission_5.xyz));
					  gl_FragData[0] = tmpvar_8;
					  gl_FragData[1] = tmpvar_9;
					  gl_FragData[2] = tmpvar_10;
					  gl_FragData[3] = outEmission_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.zw = vec2(0.0, 0.0);
					  tmpvar_3.xy = vec2(0.0, 0.0);
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
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = tmpvar_3;
					  xlv_TEXCOORD4 = max (vec3(0.0, 0.0, 0.0), tmpvar_13);
					}
					
					
					#endif
					#ifdef FRAGMENT
					#extension GL_EXT_draw_buffers : enable
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 outEmission_1;
					  lowp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_3 = tmpvar_4.xyz;
					  mediump vec4 emission_5;
					  mediump vec3 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_6 = tmpvar_3;
					  tmpvar_7 = tmpvar_2;
					  mediump vec4 tmpvar_8;
					  tmpvar_8.xyz = tmpvar_6;
					  tmpvar_8.w = 1.0;
					  mediump vec4 tmpvar_9;
					  tmpvar_9.xyz = vec3(0.0, 0.0, 0.0);
					  tmpvar_9.w = 0.0;
					  mediump vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = ((tmpvar_7 * 0.5) + 0.5);
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
					  emission_5 = tmpvar_11;
					  emission_5.xyz = (emission_5.xyz + (tmpvar_4.xyz * xlv_TEXCOORD4));
					  outEmission_1.w = emission_5.w;
					  outEmission_1.xyz = exp2(-(emission_5.xyz));
					  gl_FragData[0] = tmpvar_8;
					  gl_FragData[1] = tmpvar_9;
					  gl_FragData[2] = tmpvar_10;
					  gl_FragData[3] = outEmission_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.zw = vec2(0.0, 0.0);
					  tmpvar_3.xy = vec2(0.0, 0.0);
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
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = tmpvar_3;
					  xlv_TEXCOORD4 = max (vec3(0.0, 0.0, 0.0), tmpvar_13);
					}
					
					
					#endif
					#ifdef FRAGMENT
					#extension GL_EXT_draw_buffers : enable
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 outEmission_1;
					  lowp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_3 = tmpvar_4.xyz;
					  mediump vec4 emission_5;
					  mediump vec3 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_6 = tmpvar_3;
					  tmpvar_7 = tmpvar_2;
					  mediump vec4 tmpvar_8;
					  tmpvar_8.xyz = tmpvar_6;
					  tmpvar_8.w = 1.0;
					  mediump vec4 tmpvar_9;
					  tmpvar_9.xyz = vec3(0.0, 0.0, 0.0);
					  tmpvar_9.w = 0.0;
					  mediump vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = ((tmpvar_7 * 0.5) + 0.5);
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
					  emission_5 = tmpvar_11;
					  emission_5.xyz = (emission_5.xyz + (tmpvar_4.xyz * xlv_TEXCOORD4));
					  outEmission_1.w = emission_5.w;
					  outEmission_1.xyz = exp2(-(emission_5.xyz));
					  gl_FragData[0] = tmpvar_8;
					  gl_FragData[1] = tmpvar_9;
					  gl_FragData[2] = tmpvar_10;
					  gl_FragData[3] = outEmission_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.zw = vec2(0.0, 0.0);
					  tmpvar_3.xy = vec2(0.0, 0.0);
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
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = tmpvar_3;
					  xlv_TEXCOORD4 = max (vec3(0.0, 0.0, 0.0), tmpvar_13);
					}
					
					
					#endif
					#ifdef FRAGMENT
					#extension GL_EXT_draw_buffers : enable
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 tmpvar_1;
					  tmpvar_1 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_2 = tmpvar_3.xyz;
					  mediump vec4 emission_4;
					  mediump vec3 tmpvar_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_1;
					  mediump vec4 tmpvar_7;
					  tmpvar_7.xyz = tmpvar_5;
					  tmpvar_7.w = 1.0;
					  mediump vec4 tmpvar_8;
					  tmpvar_8.xyz = vec3(0.0, 0.0, 0.0);
					  tmpvar_8.w = 0.0;
					  mediump vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = ((tmpvar_6 * 0.5) + 0.5);
					  lowp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
					  emission_4 = tmpvar_10;
					  emission_4.xyz = (emission_4.xyz + (tmpvar_3.xyz * xlv_TEXCOORD4));
					  gl_FragData[0] = tmpvar_7;
					  gl_FragData[1] = tmpvar_8;
					  gl_FragData[2] = tmpvar_9;
					  gl_FragData[3] = emission_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.zw = vec2(0.0, 0.0);
					  tmpvar_3.xy = vec2(0.0, 0.0);
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
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = tmpvar_3;
					  xlv_TEXCOORD4 = max (vec3(0.0, 0.0, 0.0), tmpvar_13);
					}
					
					
					#endif
					#ifdef FRAGMENT
					#extension GL_EXT_draw_buffers : enable
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 tmpvar_1;
					  tmpvar_1 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_2 = tmpvar_3.xyz;
					  mediump vec4 emission_4;
					  mediump vec3 tmpvar_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_1;
					  mediump vec4 tmpvar_7;
					  tmpvar_7.xyz = tmpvar_5;
					  tmpvar_7.w = 1.0;
					  mediump vec4 tmpvar_8;
					  tmpvar_8.xyz = vec3(0.0, 0.0, 0.0);
					  tmpvar_8.w = 0.0;
					  mediump vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = ((tmpvar_6 * 0.5) + 0.5);
					  lowp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
					  emission_4 = tmpvar_10;
					  emission_4.xyz = (emission_4.xyz + (tmpvar_3.xyz * xlv_TEXCOORD4));
					  gl_FragData[0] = tmpvar_7;
					  gl_FragData[1] = tmpvar_8;
					  gl_FragData[2] = tmpvar_9;
					  gl_FragData[3] = emission_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
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
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_5;
					  tmpvar_5[0] = unity_WorldToObject[0].xyz;
					  tmpvar_5[1] = unity_WorldToObject[1].xyz;
					  tmpvar_5[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
					  worldNormal_1 = tmpvar_6;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.zw = vec2(0.0, 0.0);
					  tmpvar_3.xy = vec2(0.0, 0.0);
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
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = tmpvar_3;
					  xlv_TEXCOORD4 = max (vec3(0.0, 0.0, 0.0), tmpvar_13);
					}
					
					
					#endif
					#ifdef FRAGMENT
					#extension GL_EXT_draw_buffers : enable
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 tmpvar_1;
					  tmpvar_1 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
					  tmpvar_2 = tmpvar_3.xyz;
					  mediump vec4 emission_4;
					  mediump vec3 tmpvar_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_1;
					  mediump vec4 tmpvar_7;
					  tmpvar_7.xyz = tmpvar_5;
					  tmpvar_7.w = 1.0;
					  mediump vec4 tmpvar_8;
					  tmpvar_8.xyz = vec3(0.0, 0.0, 0.0);
					  tmpvar_8.w = 0.0;
					  mediump vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = ((tmpvar_6 * 0.5) + 0.5);
					  lowp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
					  emission_4 = tmpvar_10;
					  emission_4.xyz = (emission_4.xyz + (tmpvar_3.xyz * xlv_TEXCOORD4));
					  gl_FragData[0] = tmpvar_7;
					  gl_FragData[1] = tmpvar_8;
					  gl_FragData[2] = tmpvar_9;
					  gl_FragData[3] = emission_4;
					}
					
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES"
				}
			}
		}
		Pass {
			Name "META"
			LOD 200
			Tags { "LIGHTMODE" = "META" "RenderType" = "Opaque" }
			Cull Off
			Offset -3, -3
			GpuProgramID 362846
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					attribute vec4 _glesMultiTexCoord2;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 unity_DynamicLightmapST;
					uniform bvec4 unity_MetaVertexControl;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 vertex_1;
					  vertex_1 = _glesVertex;
					  if (unity_MetaVertexControl.x) {
					    vertex_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					    highp float tmpvar_2;
					    if ((_glesVertex.z > 0.0)) {
					      tmpvar_2 = 0.0001;
					    } else {
					      tmpvar_2 = 0.0;
					    };
					    vertex_1.z = tmpvar_2;
					  };
					  if (unity_MetaVertexControl.y) {
					    vertex_1.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
					    highp float tmpvar_3;
					    if ((vertex_1.z > 0.0)) {
					      tmpvar_3 = 0.0001;
					    } else {
					      tmpvar_3 = 0.0;
					    };
					    vertex_1.z = tmpvar_3;
					  };
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = vertex_1.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					uniform bvec4 unity_MetaFragmentControl;
					uniform highp float unity_OneOverOutputBoost;
					uniform highp float unity_MaxOutputValue;
					uniform highp float unity_UseLinearSpace;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz;
					  tmpvar_2 = tmpvar_3;
					  mediump vec4 res_4;
					  res_4 = vec4(0.0, 0.0, 0.0, 0.0);
					  if (unity_MetaFragmentControl.x) {
					    mediump vec4 tmpvar_5;
					    tmpvar_5.w = 1.0;
					    tmpvar_5.xyz = tmpvar_2;
					    res_4.w = tmpvar_5.w;
					    highp vec3 tmpvar_6;
					    tmpvar_6 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
					    res_4.xyz = tmpvar_6;
					  };
					  if (unity_MetaFragmentControl.y) {
					    mediump vec3 emission_7;
					    if (bool(unity_UseLinearSpace)) {
					      emission_7 = vec3(0.0, 0.0, 0.0);
					    } else {
					      emission_7 = vec3(0.0, 0.0, 0.0);
					    };
					    mediump vec4 tmpvar_8;
					    tmpvar_8.w = 1.0;
					    tmpvar_8.xyz = emission_7;
					    res_4 = tmpvar_8;
					  };
					  tmpvar_1 = res_4;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					attribute vec4 _glesMultiTexCoord2;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 unity_DynamicLightmapST;
					uniform bvec4 unity_MetaVertexControl;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 vertex_1;
					  vertex_1 = _glesVertex;
					  if (unity_MetaVertexControl.x) {
					    vertex_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					    highp float tmpvar_2;
					    if ((_glesVertex.z > 0.0)) {
					      tmpvar_2 = 0.0001;
					    } else {
					      tmpvar_2 = 0.0;
					    };
					    vertex_1.z = tmpvar_2;
					  };
					  if (unity_MetaVertexControl.y) {
					    vertex_1.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
					    highp float tmpvar_3;
					    if ((vertex_1.z > 0.0)) {
					      tmpvar_3 = 0.0001;
					    } else {
					      tmpvar_3 = 0.0;
					    };
					    vertex_1.z = tmpvar_3;
					  };
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = vertex_1.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					uniform bvec4 unity_MetaFragmentControl;
					uniform highp float unity_OneOverOutputBoost;
					uniform highp float unity_MaxOutputValue;
					uniform highp float unity_UseLinearSpace;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz;
					  tmpvar_2 = tmpvar_3;
					  mediump vec4 res_4;
					  res_4 = vec4(0.0, 0.0, 0.0, 0.0);
					  if (unity_MetaFragmentControl.x) {
					    mediump vec4 tmpvar_5;
					    tmpvar_5.w = 1.0;
					    tmpvar_5.xyz = tmpvar_2;
					    res_4.w = tmpvar_5.w;
					    highp vec3 tmpvar_6;
					    tmpvar_6 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
					    res_4.xyz = tmpvar_6;
					  };
					  if (unity_MetaFragmentControl.y) {
					    mediump vec3 emission_7;
					    if (bool(unity_UseLinearSpace)) {
					      emission_7 = vec3(0.0, 0.0, 0.0);
					    } else {
					      emission_7 = vec3(0.0, 0.0, 0.0);
					    };
					    mediump vec4 tmpvar_8;
					    tmpvar_8.w = 1.0;
					    tmpvar_8.xyz = emission_7;
					    res_4 = tmpvar_8;
					  };
					  tmpvar_1 = res_4;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					attribute vec4 _glesMultiTexCoord2;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 unity_DynamicLightmapST;
					uniform bvec4 unity_MetaVertexControl;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 vertex_1;
					  vertex_1 = _glesVertex;
					  if (unity_MetaVertexControl.x) {
					    vertex_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					    highp float tmpvar_2;
					    if ((_glesVertex.z > 0.0)) {
					      tmpvar_2 = 0.0001;
					    } else {
					      tmpvar_2 = 0.0;
					    };
					    vertex_1.z = tmpvar_2;
					  };
					  if (unity_MetaVertexControl.y) {
					    vertex_1.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
					    highp float tmpvar_3;
					    if ((vertex_1.z > 0.0)) {
					      tmpvar_3 = 0.0001;
					    } else {
					      tmpvar_3 = 0.0;
					    };
					    vertex_1.z = tmpvar_3;
					  };
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = vertex_1.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp vec4 _Color;
					uniform bvec4 unity_MetaFragmentControl;
					uniform highp float unity_OneOverOutputBoost;
					uniform highp float unity_MaxOutputValue;
					uniform highp float unity_UseLinearSpace;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz;
					  tmpvar_2 = tmpvar_3;
					  mediump vec4 res_4;
					  res_4 = vec4(0.0, 0.0, 0.0, 0.0);
					  if (unity_MetaFragmentControl.x) {
					    mediump vec4 tmpvar_5;
					    tmpvar_5.w = 1.0;
					    tmpvar_5.xyz = tmpvar_2;
					    res_4.w = tmpvar_5.w;
					    highp vec3 tmpvar_6;
					    tmpvar_6 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
					    res_4.xyz = tmpvar_6;
					  };
					  if (unity_MetaFragmentControl.y) {
					    mediump vec3 emission_7;
					    if (bool(unity_UseLinearSpace)) {
					      emission_7 = vec3(0.0, 0.0, 0.0);
					    } else {
					      emission_7 = vec3(0.0, 0.0, 0.0);
					    };
					    mediump vec4 tmpvar_8;
					    tmpvar_8.w = 1.0;
					    tmpvar_8.xyz = emission_7;
					    res_4 = tmpvar_8;
					  };
					  tmpvar_1 = res_4;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
			}
		}
	}
	Fallback "VertexLit"
}