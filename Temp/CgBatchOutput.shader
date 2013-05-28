Shader "Hidden/TerrainEngine/Details/Vertexlit" {
Properties {
	_Color ("Main Color r:ampl g:speed b:time", Color) = (1,1,1,1)
	_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
	_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
}

SubShader {
	Tags {"IgnoreProjector"="True" "RenderType"="TreeLeaf" }
	LOD 200
		
	
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }
		ColorMask RGB
Program "vp" {
// Vertex combos: 9
//   opengl - ALU: 37 to 96
//   d3d9 - ALU: 39 to 98
//   d3d11 - ALU: 20 to 49, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 20 to 45, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 13 [_Time]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [_Color]
Vector 24 [_MainTex_ST]
"!!ARBvp1.0
# 62 ALU
PARAM c[32] = { { 2, 1, 6.4088488, 3.1415927 },
		state.matrix.mvp,
		program.local[5..24],
		{ 1.2, 2, 1.6, 4.8000002 },
		{ 0.048, 0.059999999, 0.23999999, 0.096000001 },
		{ 0.024, 0.079999998, 0.2, -0.00019840999 },
		{ 0.0083333002, -0.16161616, 0 },
		{ 0.21538745, 0.35897908, 0.28718325, 0.86154979 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[0];
MAD R1.x, R0, -c[23].z, -vertex.color.z;
MUL R2.xyz, vertex.position.z, c[27];
ADD R1.x, R1, c[0].y;
MAD R0, vertex.position.x, c[26], R2.xyyz;
ADD R1.y, vertex.color, c[23];
MUL R1.x, R1, c[13];
MUL R1.x, R1, R1.y;
MAD R0, R1.x, c[25], R0;
FRC R0, R0;
MAD R0, R0, c[0].z, -c[0].w;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[28].y, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[28].x, R0;
ADD R3.x, vertex.color.w, c[23].w;
MUL R2.x, vertex.texcoord[0].y, R3;
MAD R0, R1, c[27].w, R0;
MUL R0, R0, R2.x;
MUL R0, R0, c[29];
MUL R0, R0, R0;
MUL R1, R0, R0;
DP4 R0.z, R1, c[30];
DP4 R0.x, R1, c[31];
MOV R0.y, c[28].z;
DP3 R1.y, R0, c[11];
DP3 R1.x, R0, c[9];
ADD R0.xz, vertex.position, -R1.xyyw;
MOV R0.yw, vertex.position;
DP4 R1.z, R0, c[7];
DP4 R1.x, R0, c[5];
DP4 R1.y, R0, c[6];
ADD result.texcoord[3].xyz, -R1, c[14];
MUL R1.xyz, vertex.normal, c[22].w;
DP3 R3.w, R1, c[6];
DP3 R2.w, R1, c[7];
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
DP3 R0.x, R1, c[5];
MOV R0.y, R3.w;
MOV R0.z, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[17];
DP4 R2.y, R0, c[16];
DP4 R2.x, R0, c[15];
MUL R0.y, R3.w, R3.w;
DP4 R3.z, R1, c[20];
DP4 R3.y, R1, c[19];
DP4 R3.x, R1, c[18];
MAD R0.y, R0.x, R0.x, -R0;
MUL R1.xyz, R0.y, c[21];
ADD R2.xyz, R2, R3;
ADD result.texcoord[2].xyz, R2, R1;
MOV result.texcoord[1].z, R2.w;
MOV result.texcoord[1].y, R3.w;
MOV result.texcoord[1].x, R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
END
# 62 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_Time]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [unity_SHAr]
Vector 15 [unity_SHAg]
Vector 16 [unity_SHAb]
Vector 17 [unity_SHBr]
Vector 18 [unity_SHBg]
Vector 19 [unity_SHBb]
Vector 20 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 21 [unity_Scale]
Vector 22 [_Color]
Vector 23 [_MainTex_ST]
"vs_2_0
; 64 ALU
def c24, 2.00000000, 1.00000000, 6.40884876, -3.14159274
def c25, 0.02400000, 0.08000000, 0.20000000, -0.16161616
def c26, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c27, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c28, 0.00833330, -0.00019841, 0.00000000, 0
def c29, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c30, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c31, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.x, c22.z
mad r1.x, c24, -r0, -v5.z
mul r2.xyz, v0.z, c25
add r1.x, r1, c24.y
mad r0, v0.x, c26, r2.xyyz
add r1.y, v5, c22
mul r1.x, r1, c12
mul r1.x, r1, r1.y
mad r0, r1.x, c27, r0
frc r0, r0
mad r0, r0, c24.z, c24.w
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c25.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c28.x, r0
add r3.x, v5.w, c22.w
mul r2.x, v3.y, r3
mad r0, r1, c28.y, r0
mul r0, r0, r2.x
mul r0, r0, c29
mul r0, r0, r0
mul r1, r0, r0
dp4 r0.z, r1, c30
dp4 r0.x, r1, c31
mov r0.y, c28.z
dp3 r1.y, r0, c10
dp3 r1.x, r0, c8
add r0.xz, v0, -r1.xyyw
mov r0.yw, v0
dp4 r1.z, r0, c6
dp4 r1.x, r0, c4
dp4 r1.y, r0, c5
add oT3.xyz, -r1, c13
mul r1.xyz, v2, c21.w
dp3 r3.w, r1, c5
dp3 r2.w, r1, c6
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
dp3 r0.x, r1, c4
mov r0.y, r3.w
mov r0.z, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c24.y
dp4 r2.z, r0, c16
dp4 r2.y, r0, c15
dp4 r2.x, r0, c14
mul r0.y, r3.w, r3.w
dp4 r3.z, r1, c19
dp4 r3.y, r1, c18
dp4 r3.x, r1, c17
mad r0.y, r0.x, r0.x, -r0
mul r1.xyz, r0.y, c20
add r2.xyz, r2, r3
add oT2.xyz, r2, r1
mov oT1.z, r2.w
mov oT1.y, r3.w
mov oT1.x, r0
mad oT0.xy, v3, c23, c23.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 112 // 96 used size, 8 vars
Vector 64 [_Color] 4
Vector 80 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 0 [_Time] 4
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 55 instructions, 5 temp regs, 0 temp arrays:
// ALU 33 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbjfgmlhgammkncjkhbmbokocddhpngmgabaaaaaammajaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcdaaiaaaaeaaaabaa
amacaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaabjaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadocbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacafaaaaaadiaaaaak
pcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedmaknhkddnaknhkddn
mnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaaaceaaaaakgjleedn
ipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaiadp
aaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaafaaaaaa
diaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaa
aaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaaaaaaaaaaaeaaaaaa
diaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaadcaaaaampcaabaaa
aaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdpjkjjjjea
egaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaap
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmneaekbfmneaekbfmnea
ekbfmneaaceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaahpcaabaaa
acaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaa
egaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
adaaaaaaaceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaaaaaaaaaa
diaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadiaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidmgfiiaidm
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaa
ehamfaljehamfaljehamfaljehamfaljegaobaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddoihiofmdpdiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaa
egaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdnbbaaaaak
bcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedmaknhcddnipmcpfln
kgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaaagiccaaaadaaaaaa
bcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaabaaaaaaaagaabaaa
aaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaa
aaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
afaaaaaaogikcaaaaaaaaaaaafaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaa
abaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaa
adaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaa
dgaaaaafhccabaaaacaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaaabaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaabcaaaaaa
egaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaabdaaaaaa
egaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaabeaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaa
abaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaabfaaaaaaegaobaaa
adaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaabgaaaaaaegaobaaa
adaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaabhaaaaaaegaobaaa
adaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaa
diaaaaahecaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaak
ecaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaackaabaiaebaaaaaa
aaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaabiaaaaaakgakbaaa
aaaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakncaabaaaaaaaaaaaagijcaaaadaaaaaa
amaaaaaaagaabaaaaaaaaaaaagajbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaafgafbaaaaaaaaaaaigadbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhccabaaaaeaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 112 // 96 used size, 8 vars
Vector 64 [_Color] 4
Vector 80 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 0 [_Time] 4
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 55 instructions, 5 temp regs, 0 temp arrays:
// ALU 33 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_3
eefiecedfghbpommcdhgmfiiiojgmgbkeijelgijabaaaaaaceapaaaaaeaaaaaa
daaaaaaaieafaaaalmanaaaaieaoaaaaebgpgodjemafaaaaemafaaaaaaacpopp
meaeaaaaiiaaaaaaaiaaceaaaaaaieaaaaaaieaaaaaaceaaabaaieaaaaaaaeaa
acaaabaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaaabaaaeaaabaaaeaaaaaaaaaa
acaabcaaahaaafaaaaaaaaaaadaaaaaaaeaaamaaaaaaaaaaadaaamaaafaabaaa
aaaaaaaaadaabcaaabaabfaaaaaaaaaaadaabeaaabaabgaaaaaaaaaaaaaaaaaa
abacpoppfbaaaaafbhaaapkakgjleednipmchfdnipmchfdokgjlmednfbaaaaaf
biaaapkakgjlmedmaknhkddnmnmmemdolfhocflofbaaaaafbjaaapkaaaaaaaea
aaaaiadpekbfmneanlapejmafbaaaaafbkaaapkajkjjjjdpaaaaaaeamnmmmmdp
jkjjjjeafbaaaaafblaaapkagfiiaidmehamfaljaaaaaaaaaaaaaaaafbaaaaaf
bmaaapkaihiofmdoblmmlhdokpajjddoihiofmdpfbaaaaafbnaaapkakgjlmedm
aknhcddnipmcpflnkgjlmednfbaaaaafboaaapkakgjlmedlaknhkddmaknhkdlm
mnmmmmdnbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaafiaafaaapjaaeaaaaaeaaaaadoaadaaoeja
acaaoekaacaaookaafaaaaadaaaaapiaaaaakkjabiaajekaaeaaaaaeaaaaapia
aaaaaajabhaaoekaaaaaoeiaabaaaaacabaaadiabjaaoekaaeaaaaaeabaaabia
abaakkkaabaaaaibabaaffiaacaaaaadabaaabiaabaaaaiaafaakkjbafaaaaad
abaaabiaabaaaaiaadaaaakaacaaaaadabaaagiaafaapejaabaapekaafaaaaad
abaaabiaabaaffiaabaaaaiaafaaaaadabaaaciaabaakkiaadaaffjaaeaaaaae
aaaaapiaabaaaaiabkaaoekaaaaaoeiabdaaaaacaaaaapiaaaaaoeiaaeaaaaae
aaaaapiaaaaaoeiabjaakkkabjaappkaafaaaaadacaaapiaaaaaoeiaaaaaoeia
afaaaaadadaaapiaaaaaoeiaacaaoeiaaeaaaaaeaaaaapiaadaaoeiabiaappka
aaaaoeiaafaaaaadadaaapiaacaaoeiaadaaoeiaafaaaaadacaaapiaacaaoeia
adaaoeiaaeaaaaaeaaaaapiaadaaoeiablaaaakaaaaaoeiaaeaaaaaeaaaaapia
acaaoeiablaaffkaaaaaoeiaafaaaaadaaaaapiaabaaffiaaaaaoeiaafaaaaad
aaaaapiaaaaaoeiabmaaoekaafaaaaadaaaaapiaaaaaoeiaaaaaoeiaafaaaaad
aaaaapiaaaaaoeiaaaaaoeiaajaaaaadabaaabiaaaaaoeiaboaaoekaajaaaaad
aaaaabiaaaaaoeiabnaaoekaafaaaaadaaaaagiaabaaaaiabfaaoakaaeaaaaae
aaaaadiabeaaoikaaaaaaaiaaaaaojiaacaaaaadaaaaadiaaaaaoeibaaaaoija
afaaaaadabaaahiaaaaaffjabbaaoekaaeaaaaaeabaaahiabaaaoekaaaaaaaia
abaaoeiaaeaaaaaeabaaahiabcaaoekaaaaaffiaabaaoeiaaeaaaaaeabaaahia
bdaaoekaaaaappjaabaaoeiaacaaaaadadaaahoaabaaoeibaeaaoekaafaaaaad
abaaahiaacaaoejabgaappkaafaaaaadacaaahiaabaaffiabbaaoekaaeaaaaae
abaaaliabaaakekaabaaaaiaacaakeiaaeaaaaaeabaaahiabcaaoekaabaakkia
abaapeiaabaaaaacabaaaiiabjaaffkaajaaaaadacaaabiaafaaoekaabaaoeia
ajaaaaadacaaaciaagaaoekaabaaoeiaajaaaaadacaaaeiaahaaoekaabaaoeia
afaaaaadadaaapiaabaacjiaabaakeiaajaaaaadaeaaabiaaiaaoekaadaaoeia
ajaaaaadaeaaaciaajaaoekaadaaoeiaajaaaaadaeaaaeiaakaaoekaadaaoeia
acaaaaadacaaahiaacaaoeiaaeaaoeiaafaaaaadaaaaaeiaabaaffiaabaaffia
aeaaaaaeaaaaaeiaabaaaaiaabaaaaiaaaaakkibabaaaaacabaaahoaabaaoeia
aeaaaaaeacaaahoaalaaoekaaaaakkiaacaaoeiaafaaaaadabaaapiaaaaaffja
anaaoekaaeaaaaaeabaaapiaamaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaapia
aoaaoekaaaaaffiaabaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
ppppaaaafdeieefcdaaiaaaaeaaaabaaamacaaaafjaaaaaeegiocaaaaaaaaaaa
agaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
bjaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadocbabaaa
afaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagiaaaaacafaaaaaadiaaaaakpcaabaaaaaaaaaaakgbkbaaaaaaaaaaa
aceaaaaakgjlmedmaknhkddnaknhkddnmnmmemdodcaaaaampcaabaaaaaaaaaaa
agbabaaaaaaaaaaaaceaaaaakgjleednipmchfdnipmchfdokgjlmednegaobaaa
aaaaaaaadcaaaaalbcaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaa
abeaaaaaaaaaaaeaabeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaackbabaiaebaaaaaaafaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaaakiacaaaabaaaaaaaaaaaaaaaaaaaaaigcaabaaaabaaaaaafgbhbaaa
afaaaaaafgihcaaaaaaaaaaaaeaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaabaaaaaa
bkbabaaaadaaaaaadcaaaaampcaabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaa
jkjjjjdpaaaaaaeamnmmmmdpjkjjjjeaegaobaaaaaaaaaaabkaaaaafpcaabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaaekbfmneaekbfmneaekbfmneaekbfmneaaceaaaaanlapejmanlapejma
nlapejmanlapejmadiaaaaahpcaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaalfhocflolfhocflo
lfhocflolfhocfloegaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaadaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaa
gfiiaidmgfiiaidmgfiiaidmgfiiaidmegaobaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaacaaaaaaaceaaaaaehamfaljehamfaljehamfaljehamfalj
egaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaafgafbaaaabaaaaaaegaobaaa
aaaaaaaadiaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaihiofmdo
blmmlhdokpajjddoihiofmdpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
aaaaaaaabbaaaaakbcaabaaaabaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedl
aknhkddmaknhkdlmmnmmmmdnbbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaakgjlmedmaknhcddnipmcpflnkgjlmedndiaaaaaigcaabaaaaaaaaaaa
agaabaaaabaaaaaaagiccaaaadaaaaaabcaaaaaadcaaaaakdcaabaaaaaaaaaaa
igiacaaaadaaaaaabaaaaaaaagaabaaaaaaaaaaajgafbaaaaaaaaaaaaaaaaaai
dcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaaigbabaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaafgafbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
diaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
diaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaabaaaaaa
egaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaafhccabaaaacaaaaaaegacbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
acaaaaaaegiocaaaacaaaaaabcaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaa
acaaaaaaegiocaaaacaaaaaabdaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaa
acaaaaaaegiocaaaacaaaaaabeaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaa
adaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaa
egiocaaaacaaaaaabfaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaa
egiocaaaacaaaaaabgaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaa
egiocaaaacaaaaaabhaaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaa
abaaaaaabkaabaaaabaaaaaadcaaaaakecaabaaaaaaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaadaaaaaa
egiccaaaacaaaaaabiaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
ncaabaaaaaaaaaaaagijcaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaagajbaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaafgafbaaa
aaaaaaaaigadbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaaeaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaoaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Vector 13 [_Time]
Matrix 9 [_World2Object]
Vector 14 [_Color]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
"!!ARBvp1.0
# 37 ALU
PARAM c[24] = { { 2, 1, 6.4088488, 3.1415927 },
		state.matrix.mvp,
		program.local[5..16],
		{ 1.2, 2, 1.6, 4.8000002 },
		{ 0.048, 0.059999999, 0.23999999, 0.096000001 },
		{ 0.024, 0.079999998, 0.2, -0.00019840999 },
		{ 0.0083333002, -0.16161616, 0 },
		{ 0.21538745, 0.35897908, 0.28718325, 0.86154979 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[0];
MAD R1.x, R0, -c[14].z, -vertex.color.z;
MUL R2.xyz, vertex.position.z, c[19];
ADD R1.x, R1, c[0].y;
MAD R0, vertex.position.x, c[18], R2.xyyz;
ADD R1.y, vertex.color, c[14];
MUL R1.x, R1, c[13];
MUL R1.x, R1, R1.y;
MAD R0, R1.x, c[17], R0;
FRC R0, R0;
MAD R0, R0, c[0].z, -c[0].w;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[20].y, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[20].x, R0;
ADD R3.x, vertex.color.w, c[14].w;
MAD R0, R1, c[19].w, R0;
MUL R2.x, vertex.texcoord[0].y, R3;
MUL R0, R0, R2.x;
MUL R0, R0, c[21];
MUL R0, R0, R0;
MUL R1, R0, R0;
DP4 R0.z, R1, c[22];
DP4 R0.x, R1, c[23];
MOV R0.y, c[20].z;
DP3 R1.y, R0, c[11];
DP3 R1.x, R0, c[9];
MOV R0.yw, vertex.position;
ADD R0.xz, vertex.position, -R1.xyyw;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[15], c[15].zwzw;
END
# 37 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_Time]
Matrix 8 [_World2Object]
Vector 13 [_Color]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
"vs_2_0
; 39 ALU
def c16, 2.00000000, 1.00000000, 6.40884876, -3.14159274
def c17, 0.02400000, 0.08000000, 0.20000000, -0.16161616
def c18, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c19, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c20, 0.00833330, -0.00019841, 0.00000000, 0
def c21, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c22, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c23, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r0.x, c13.z
mad r1.x, c16, -r0, -v5.z
mul r2.xyz, v0.z, c17
add r1.x, r1, c16.y
mad r0, v0.x, c18, r2.xyyz
add r1.y, v5, c13
mul r1.x, r1, c12
mul r1.x, r1, r1.y
mad r0, r1.x, c19, r0
frc r0, r0
mad r0, r0, c16.z, c16.w
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c17.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c20.x, r0
add r3.x, v5.w, c13.w
mad r0, r1, c20.y, r0
mul r2.x, v3.y, r3
mul r0, r0, r2.x
mul r0, r0, c21
mul r0, r0, r0
mul r1, r0, r0
dp4 r0.z, r1, c22
dp4 r0.x, r1, c23
mov r0.y, c20.z
dp3 r1.y, r0, c10
dp3 r1.x, r0, c8
mov r0.yw, v0
add r0.xz, v0, -r1.xyyw
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
mad oT0.xy, v3, c15, c15.zwzw
mad oT1.xy, v4, c14, c14.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 128 // 112 used size, 9 vars
Vector 64 [_Color] 4
Vector 80 [unity_LightmapST] 4
Vector 96 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityPerDraw" 336 // 320 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 256 [_World2Object] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 34 instructions, 4 temp regs, 0 temp arrays:
// ALU 20 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedadajopdbkkjeiibhcbgnbhhlompmapmmabaaaaaamiagaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcfmafaaaaeaaaabaafhabaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaafpaaaaadocbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagiaaaaac
aeaaaaaadiaaaaakpcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedm
aknhkddnaknhkddnmnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaa
aceaaaaakgjleednipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaal
bcaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaea
abeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaia
ebaaaaaaafaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaa
abaaaaaaaaaaaaaaaaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaa
aaaaaaaaaeaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaa
dcaaaaampcaabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaea
mnmmmmdpjkjjjjeaegaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmnea
ekbfmneaekbfmneaekbfmneaaceaaaaanlapejmanlapejmanlapejmanlapejma
diaaaaahpcaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaah
pcaabaaaadaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaadaaaaaaaceaaaaalfhocflolfhocflolfhocflolfhocflo
egaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
adaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidm
gfiiaidmgfiiaidmegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
acaaaaaaaceaaaaaehamfaljehamfaljehamfaljehamfaljegaobaaaaaaaaaaa
diaaaaahpcaabaaaaaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaak
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddo
ihiofmdpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaak
bcaabaaaabaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlm
mnmmmmdnbbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedm
aknhcddnipmcpflnkgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaa
agiccaaaacaaaaaabcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaaacaaaaaa
baaaaaaaagaabaaaaaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaa
egaabaiaebaaaaaaaaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaacaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaafaaaaaakgiocaaaaaaaaaaa
afaaaaaadoaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 128 // 112 used size, 9 vars
Vector 64 [_Color] 4
Vector 80 [unity_LightmapST] 4
Vector 96 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityPerDraw" 336 // 320 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 256 [_World2Object] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 34 instructions, 4 temp regs, 0 temp arrays:
// ALU 20 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_3
eefiecedbacchglccgemlmoffmkppgmmfjinjghkabaaaaaajmakaaaaaeaaaaaa
daaaaaaaaaaeaaaageajaaaacmakaaaaebgpgodjmiadaaaamiadaaaaaaacpopp
geadaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaaeaa
adaaabaaaaaaaaaaabaaaaaaabaaaeaaaaaaaaaaacaaaaaaaeaaafaaaaaaaaaa
acaabaaaabaaajaaaaaaaaaaacaabcaaabaaakaaaaaaaaaaaaaaaaaaabacpopp
fbaaaaafalaaapkakgjleednipmchfdnipmchfdokgjlmednfbaaaaafamaaapka
kgjlmedmaknhkddnmnmmemdolfhocflofbaaaaafanaaapkaaaaaaaeaaaaaiadp
ekbfmneanlapejmafbaaaaafaoaaapkajkjjjjdpaaaaaaeamnmmmmdpjkjjjjea
fbaaaaafapaaapkagfiiaidmehamfaljaaaaaaaaaaaaaaaafbaaaaafbaaaapka
ihiofmdoblmmlhdokpajjddoihiofmdpfbaaaaafbbaaapkakgjlmedmaknhcddn
ipmcpflnkgjlmednfbaaaaafbcaaapkakgjlmedlaknhkddmaknhkdlmmnmmmmdn
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeia
aeaaapjabpaaaaacafaaafiaafaaapjaaeaaaaaeaaaaadoaadaaoejaadaaoeka
adaaookaaeaaaaaeaaaaamoaaeaabejaacaabekaacaalekaafaaaaadaaaaapia
aaaakkjaamaajekaaeaaaaaeaaaaapiaaaaaaajaalaaoekaaaaaoeiaabaaaaac
abaaadiaanaaoekaaeaaaaaeabaaabiaabaakkkaabaaaaibabaaffiaacaaaaad
abaaabiaabaaaaiaafaakkjbafaaaaadabaaabiaabaaaaiaaeaaaakaacaaaaad
abaaagiaafaapejaabaapekaafaaaaadabaaabiaabaaffiaabaaaaiaafaaaaad
abaaaciaabaakkiaadaaffjaaeaaaaaeaaaaapiaabaaaaiaaoaaoekaaaaaoeia
bdaaaaacaaaaapiaaaaaoeiaaeaaaaaeaaaaapiaaaaaoeiaanaakkkaanaappka
afaaaaadacaaapiaaaaaoeiaaaaaoeiaafaaaaadadaaapiaaaaaoeiaacaaoeia
aeaaaaaeaaaaapiaadaaoeiaamaappkaaaaaoeiaafaaaaadadaaapiaacaaoeia
adaaoeiaafaaaaadacaaapiaacaaoeiaadaaoeiaaeaaaaaeaaaaapiaadaaoeia
apaaaakaaaaaoeiaaeaaaaaeaaaaapiaacaaoeiaapaaffkaaaaaoeiaafaaaaad
aaaaapiaabaaffiaaaaaoeiaafaaaaadaaaaapiaaaaaoeiabaaaoekaafaaaaad
aaaaapiaaaaaoeiaaaaaoeiaafaaaaadaaaaapiaaaaaoeiaaaaaoeiaajaaaaad
abaaabiaaaaaoeiabcaaoekaajaaaaadaaaaabiaaaaaoeiabbaaoekaafaaaaad
aaaaagiaabaaaaiaakaaoakaaeaaaaaeaaaaadiaajaaoikaaaaaaaiaaaaaojia
acaaaaadaaaaadiaaaaaoeibaaaaoijaafaaaaadabaaapiaaaaaffjaagaaoeka
aeaaaaaeabaaapiaafaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaapiaahaaoeka
aaaaffiaabaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
fdeieefcfmafaaaaeaaaabaafhabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaa
aeaaaaaafpaaaaadocbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagiaaaaacaeaaaaaa
diaaaaakpcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedmaknhkddn
aknhkddnmnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaaaceaaaaa
kgjleednipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaalbcaabaaa
abaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeaabeaaaaa
aaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaa
afaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaabaaaaaa
aaaaaaaaaaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaaaaaaaaaa
aeaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaadcaaaaam
pcaabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdp
jkjjjjeaegaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmneaekbfmnea
ekbfmneaekbfmneaaceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaah
pcaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
adaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaadaaaaaaaceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaa
aaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaa
diaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidm
gfiiaidmegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaa
aceaaaaaehamfaljehamfaljehamfaljehamfaljegaobaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddoihiofmdp
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaakbcaabaaa
abaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdn
bbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedmaknhcddn
ipmcpflnkgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaaagiccaaa
acaaaaaabcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaaacaaaaaabaaaaaaa
agaabaaaaaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaia
ebaaaaaaaaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
acaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaaeaaaaaaagiecaaaaaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 13 [_Time]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_ProjectionParams]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 23 [unity_Scale]
Vector 24 [_Color]
Vector 25 [_MainTex_ST]
"!!ARBvp1.0
# 67 ALU
PARAM c[33] = { { 2, 1, 6.4088488, 3.1415927 },
		state.matrix.mvp,
		program.local[5..25],
		{ 1.2, 2, 1.6, 4.8000002 },
		{ 0.048, 0.059999999, 0.23999999, 0.096000001 },
		{ 0.024, 0.079999998, 0.2, -0.00019840999 },
		{ 0.0083333002, -0.16161616, 0, 0.5 },
		{ 0.21538745, 0.35897908, 0.28718325, 0.86154979 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[0];
MAD R1.x, R0, -c[24].z, -vertex.color.z;
MUL R2.xyz, vertex.position.z, c[28];
ADD R1.x, R1, c[0].y;
MAD R0, vertex.position.x, c[27], R2.xyyz;
ADD R1.y, vertex.color, c[24];
MUL R1.x, R1, c[13];
MUL R1.x, R1, R1.y;
MAD R0, R1.x, c[26], R0;
FRC R0, R0;
MAD R0, R0, c[0].z, -c[0].w;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[29].y, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[29].x, R0;
MAD R0, R1, c[28].w, R0;
ADD R3.x, vertex.color.w, c[24].w;
MUL R2.x, vertex.texcoord[0].y, R3;
MUL R0, R0, R2.x;
MUL R0, R0, c[30];
MUL R0, R0, R0;
MUL R0, R0, R0;
DP4 R1.z, R0, c[31];
DP4 R1.x, R0, c[32];
MOV R1.y, c[29].z;
DP3 R0.y, R1, c[11];
DP3 R0.x, R1, c[9];
ADD R1.xz, vertex.position, -R0.xyyw;
MOV R1.yw, vertex.position;
DP4 R0.w, R1, c[4];
DP4 R0.z, R1, c[3];
DP4 R0.x, R1, c[1];
DP4 R0.y, R1, c[2];
MUL R2.xyz, R0.xyww, c[29].w;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MUL R2.y, R2, c[15].x;
DP4 R0.z, R1, c[7];
DP4 R0.y, R1, c[6];
DP4 R0.x, R1, c[5];
MUL R1.xyz, vertex.normal, c[23].w;
DP3 R3.w, R1, c[6];
ADD result.texcoord[3].xyz, -R0, c[14];
DP3 R2.w, R1, c[7];
DP3 R0.x, R1, c[5];
MOV R0.y, R3.w;
MOV R0.z, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
ADD result.texcoord[4].xy, R2, R2.z;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[18];
DP4 R2.y, R0, c[17];
DP4 R2.x, R0, c[16];
MUL R0.y, R3.w, R3.w;
DP4 R3.z, R1, c[21];
DP4 R3.y, R1, c[20];
DP4 R3.x, R1, c[19];
MAD R0.y, R0.x, R0.x, -R0;
MUL R1.xyz, R0.y, c[22];
ADD R2.xyz, R2, R3;
ADD result.texcoord[2].xyz, R2, R1;
MOV result.texcoord[1].z, R2.w;
MOV result.texcoord[1].y, R3.w;
MOV result.texcoord[1].x, R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[25], c[25].zwzw;
END
# 67 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_Time]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_ScreenParams]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 23 [unity_Scale]
Vector 24 [_Color]
Vector 25 [_MainTex_ST]
"vs_2_0
; 69 ALU
def c26, 2.00000000, 1.00000000, 6.40884876, -3.14159274
def c27, 0.02400000, 0.08000000, 0.20000000, -0.16161616
def c28, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c29, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c30, 0.00833330, -0.00019841, 0.00000000, 0.50000000
def c31, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c32, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c33, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.x, c24.z
mad r1.x, c26, -r0, -v5.z
mul r2.xyz, v0.z, c27
add r1.x, r1, c26.y
mad r0, v0.x, c28, r2.xyyz
add r1.y, v5, c24
mul r1.x, r1, c12
mul r1.x, r1, r1.y
mad r0, r1.x, c29, r0
frc r0, r0
mad r0, r0, c26.z, c26.w
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c27.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c30.x, r0
mad r0, r1, c30.y, r0
add r3.x, v5.w, c24.w
mul r2.x, v3.y, r3
mul r0, r0, r2.x
mul r0, r0, c31
mul r0, r0, r0
mul r0, r0, r0
dp4 r1.z, r0, c32
dp4 r1.x, r0, c33
mov r1.y, c30.z
dp3 r0.y, r1, c10
dp3 r0.x, r1, c8
add r1.xz, v0, -r0.xyyw
mov r1.yw, v0
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r2.xyz, r0.xyww, c30.w
mov oPos, r0
mov oT4.zw, r0
mul r2.y, r2, c14.x
dp4 r0.z, r1, c6
dp4 r0.y, r1, c5
dp4 r0.x, r1, c4
mul r1.xyz, v2, c23.w
dp3 r3.w, r1, c5
add oT3.xyz, -r0, c13
dp3 r2.w, r1, c6
dp3 r0.x, r1, c4
mov r0.y, r3.w
mov r0.z, r2.w
mul r1, r0.xyzz, r0.yzzx
mad oT4.xy, r2.z, c15.zwzw, r2
mov r0.w, c26.y
dp4 r2.z, r0, c18
dp4 r2.y, r0, c17
dp4 r2.x, r0, c16
mul r0.y, r3.w, r3.w
dp4 r3.z, r1, c21
dp4 r3.y, r1, c20
dp4 r3.x, r1, c19
mad r0.y, r0.x, r0.x, -r0
mul r1.xyz, r0.y, c22
add r2.xyz, r2, r3
add oT2.xyz, r2, r1
mov oT1.z, r2.w
mov oT1.y, r3.w
mov oT1.x, r0
mad oT0.xy, v3, c25, c25.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 176 // 160 used size, 9 vars
Vector 128 [_Color] 4
Vector 144 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 0 [_Time] 4
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 61 instructions, 6 temp regs, 0 temp arrays:
// ALU 37 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhobocjpmefplmdoebceglpjeiijdlepoabaaaaaajiakaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcoeaiaaaaeaaaabaadjacaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaabjaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadocbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacagaaaaaa
diaaaaakpcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedmaknhkddn
aknhkddnmnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaaaceaaaaa
kgjleednipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaalbcaabaaa
abaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeaabeaaaaa
aaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaa
afaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaabaaaaaa
aaaaaaaaaaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaaaaaaaaaa
aiaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaadcaaaaam
pcaabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdp
jkjjjjeaegaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmneaekbfmnea
ekbfmneaekbfmneaaceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaah
pcaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
adaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaadaaaaaaaceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaa
aaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaa
diaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidm
gfiiaidmegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaa
aceaaaaaehamfaljehamfaljehamfaljehamfaljegaobaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddoihiofmdp
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaakbcaabaaa
abaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdn
bbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedmaknhcddn
ipmcpflnkgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaaagiccaaa
adaaaaaabcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaabaaaaaaa
agaabaaaaaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaia
ebaaaaaaaaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaa
aaaaaaaaajaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaaacaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaacaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaacaaaaaaegaibaaaadaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaacaaaaaaegadbaaaacaaaaaadgaaaaafhccabaaa
acaaaaaaegacbaaaacaaaaaadgaaaaaficaabaaaacaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaabcaaaaaaegaobaaaacaaaaaa
bbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaabdaaaaaaegaobaaaacaaaaaa
bbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaabeaaaaaaegaobaaaacaaaaaa
diaaaaahpcaabaaaaeaaaaaajgacbaaaacaaaaaaegakbaaaacaaaaaabbaaaaai
bcaabaaaafaaaaaaegiocaaaacaaaaaabfaaaaaaegaobaaaaeaaaaaabbaaaaai
ccaabaaaafaaaaaaegiocaaaacaaaaaabgaaaaaaegaobaaaaeaaaaaabbaaaaai
ecaabaaaafaaaaaaegiocaaaacaaaaaabhaaaaaaegaobaaaaeaaaaaaaaaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaafaaaaaadiaaaaahecaabaaa
aaaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakecaabaaaaaaaaaaa
akaabaaaacaaaaaaakaabaaaacaaaaaackaabaiaebaaaaaaaaaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaacaaaaaabiaaaaaakgakbaaaaaaaaaaaegacbaaa
adaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakncaabaaaaaaaaaaaagijcaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaagajbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaafgafbaaaaaaaaaaaigadbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hccabaaaaeaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaa
diaaaaaibcaabaaaaaaaaaaabkaabaaaabaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdiaaaaak
fcaabaaaaaaaaaaaagadbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaaaadgaaaaafmccabaaaafaaaaaakgaobaaaabaaaaaaaaaaaaahdccabaaa
afaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaadoaaaaab"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Vector 13 [_Time]
Vector 14 [_ProjectionParams]
Matrix 9 [_World2Object]
Vector 15 [_Color]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
"!!ARBvp1.0
# 42 ALU
PARAM c[25] = { { 2, 1, 6.4088488, 3.1415927 },
		state.matrix.mvp,
		program.local[5..17],
		{ 1.2, 2, 1.6, 4.8000002 },
		{ 0.048, 0.059999999, 0.23999999, 0.096000001 },
		{ 0.024, 0.079999998, 0.2, -0.00019840999 },
		{ 0.0083333002, -0.16161616, 0, 0.5 },
		{ 0.21538745, 0.35897908, 0.28718325, 0.86154979 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[0];
MAD R1.x, R0, -c[15].z, -vertex.color.z;
MUL R2.xyz, vertex.position.z, c[20];
ADD R1.x, R1, c[0].y;
MAD R0, vertex.position.x, c[19], R2.xyyz;
ADD R1.y, vertex.color, c[15];
MUL R1.x, R1, c[13];
MUL R1.x, R1, R1.y;
MAD R0, R1.x, c[18], R0;
FRC R0, R0;
MAD R0, R0, c[0].z, -c[0].w;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[21].y, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[21].x, R0;
MAD R0, R1, c[20].w, R0;
ADD R3.x, vertex.color.w, c[15].w;
MUL R2.x, vertex.texcoord[0].y, R3;
MUL R0, R0, R2.x;
MUL R0, R0, c[22];
MUL R0, R0, R0;
MUL R0, R0, R0;
DP4 R1.z, R0, c[23];
DP4 R1.x, R0, c[24];
MOV R1.y, c[21].z;
DP3 R0.y, R1, c[11];
DP3 R0.x, R1, c[9];
ADD R1.xz, vertex.position, -R0.xyyw;
MOV R1.yw, vertex.position;
DP4 R0.w, R1, c[4];
DP4 R0.z, R1, c[3];
DP4 R0.x, R1, c[1];
DP4 R0.y, R1, c[2];
MUL R2.xyz, R0.xyww, c[21].w;
MUL R2.y, R2, c[14].x;
ADD result.texcoord[2].xy, R2, R2.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[16], c[16].zwzw;
END
# 42 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_Time]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_World2Object]
Vector 15 [_Color]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
"vs_2_0
; 44 ALU
def c18, 2.00000000, 1.00000000, 6.40884876, -3.14159274
def c19, 0.02400000, 0.08000000, 0.20000000, -0.16161616
def c20, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c21, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c22, 0.00833330, -0.00019841, 0.00000000, 0.50000000
def c23, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c24, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c25, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r0.x, c15.z
mad r1.x, c18, -r0, -v5.z
mul r2.xyz, v0.z, c19
add r1.x, r1, c18.y
mad r0, v0.x, c20, r2.xyyz
add r1.y, v5, c15
mul r1.x, r1, c12
mul r1.x, r1, r1.y
mad r0, r1.x, c21, r0
frc r0, r0
mad r0, r0, c18.z, c18.w
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c19.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c22.x, r0
mad r0, r1, c22.y, r0
add r3.x, v5.w, c15.w
mul r2.x, v3.y, r3
mul r0, r0, r2.x
mul r0, r0, c23
mul r0, r0, r0
mul r0, r0, r0
dp4 r1.z, r0, c24
dp4 r1.x, r0, c25
mov r1.y, c22.z
dp3 r0.y, r1, c10
dp3 r0.x, r1, c8
add r1.xz, v0, -r0.xyyw
mov r1.yw, v0
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r2.xyz, r0.xyww, c22.w
mul r2.y, r2, c13.x
mad oT2.xy, r2.z, c14.zwzw, r2
mov oPos, r0
mov oT2.zw, r0
mad oT0.xy, v3, c17, c17.zwzw
mad oT1.xy, v4, c16, c16.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 192 // 176 used size, 10 vars
Vector 128 [_Color] 4
Vector 144 [unity_LightmapST] 4
Vector 160 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 0 [_Time] 4
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 320 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 256 [_World2Object] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 39 instructions, 4 temp regs, 0 temp arrays:
// ALU 23 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedgllemnadabbnjidafajgbmbojmhpdjpnabaaaaaahiahaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
peafaaaaeaaaabaahnabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
fpaaaaadocbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacaeaaaaaadiaaaaakpcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaa
kgjlmedmaknhkddnaknhkddnmnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaa
aaaaaaaaaceaaaaakgjleednipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaa
dcaaaaalbcaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaaabeaaaaa
aaaaaaeaabeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
ckbabaiaebaaaaaaafaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
akiacaaaabaaaaaaaaaaaaaaaaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaa
fgihcaaaaaaaaaaaaiaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaa
adaaaaaadcaaaaampcaabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdp
aaaaaaeamnmmmmdpjkjjjjeaegaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
ekbfmneaekbfmneaekbfmneaekbfmneaaceaaaaanlapejmanlapejmanlapejma
nlapejmadiaaaaahpcaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaahpcaabaaaadaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaalfhocflolfhocflolfhocflo
lfhocfloegaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaadaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
adaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidm
gfiiaidmgfiiaidmgfiiaidmegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaacaaaaaaaceaaaaaehamfaljehamfaljehamfaljehamfaljegaobaaa
aaaaaaaadiaaaaahpcaabaaaaaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdo
kpajjddoihiofmdpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaa
bbaaaaakbcaabaaaabaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddm
aknhkdlmmnmmmmdnbbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
kgjlmedmaknhcddnipmcpflnkgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaa
abaaaaaaagiccaaaacaaaaaabcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaa
acaaaaaabaaaaaaaagaabaaaaaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaa
aaaaaaaaegaabaiaebaaaaaaaaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaacaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaafgafbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
akaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
aeaaaaaaagiecaaaaaaaaaaaajaaaaaakgiocaaaaaaaaaaaajaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
acaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 13 [_Time]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 18 [unity_4LightAtten0]
Vector 19 [unity_LightColor0]
Vector 20 [unity_LightColor1]
Vector 21 [unity_LightColor2]
Vector 22 [unity_LightColor3]
Vector 23 [unity_SHAr]
Vector 24 [unity_SHAg]
Vector 25 [unity_SHAb]
Vector 26 [unity_SHBr]
Vector 27 [unity_SHBg]
Vector 28 [unity_SHBb]
Vector 29 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 30 [unity_Scale]
Vector 31 [_Color]
Vector 32 [_MainTex_ST]
"!!ARBvp1.0
# 90 ALU
PARAM c[40] = { { 2, 1, 6.4088488, 3.1415927 },
		state.matrix.mvp,
		program.local[5..32],
		{ 1.2, 2, 1.6, 4.8000002 },
		{ 0.048, 0.059999999, 0.23999999, 0.096000001 },
		{ 0.024, 0.079999998, 0.2, -0.00019840999 },
		{ 0.0083333002, -0.16161616, 0 },
		{ 0.21538745, 0.35897908, 0.28718325, 0.86154979 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
MOV R0.x, c[0];
MUL R1.xyz, vertex.position.z, c[35];
MAD R0.x, R0, -c[31].z, -vertex.color.z;
ADD R0.x, R0, c[0].y;
MOV R8.w, c[0].y;
MAD R1, vertex.position.x, c[34], R1.xyyz;
ADD R0.y, vertex.color, c[31];
MUL R0.x, R0, c[13];
MUL R0.x, R0, R0.y;
MAD R0, R0.x, c[33], R1;
FRC R0, R0;
MAD R1, R0, c[0].z, -c[0].w;
MUL R0, R1, R1;
MUL R2, R0, R1;
MAD R1, R2, c[36].y, R1;
MUL R2, R2, R0;
MAD R1, R2, c[36].x, R1;
MUL R0, R2, R0;
MAD R0, R0, c[35].w, R1;
ADD R3.x, vertex.color.w, c[31].w;
MUL R2.x, vertex.texcoord[0].y, R3;
MUL R0, R0, R2.x;
MUL R0, R0, c[37];
MUL R0, R0, R0;
MUL R0, R0, R0;
DP4 R1.z, R0, c[38];
DP4 R1.x, R0, c[39];
MOV R1.y, c[36].z;
DP3 R0.y, R1, c[11];
DP3 R0.x, R1, c[9];
ADD R1.xz, vertex.position, -R0.xyyw;
MOV R1.yw, vertex.position;
DP4 R7.xy, R1, c[6];
ADD R3, -R7.x, c[16];
DP4 R6.zw, R1, c[7];
DP4 R7.x, R1, c[5];
MOV R7.z, R6.w;
MUL R0, R3, R3;
ADD R2, -R7.x, c[15];
MAD R4, R2, R2, R0;
ADD R0, -R6.z, c[17];
MUL R6.xyz, vertex.normal, c[30].w;
DP3 R7.w, R6, c[6];
MAD R4, R0, R0, R4;
DP3 R8.x, R6, c[5];
MUL R3, R7.w, R3;
MAD R2, R8.x, R2, R3;
DP3 R3.x, R6, c[7];
MAD R0, R3.x, R0, R2;
MUL R5, R4, c[18];
MOV R8.y, R7.w;
MOV R8.z, R3.x;
RSQ R2.x, R4.x;
RSQ R2.y, R4.y;
RSQ R2.z, R4.z;
RSQ R2.w, R4.w;
MUL R0, R0, R2;
ADD R2, R5, c[0].y;
RCP R2.x, R2.x;
RCP R2.y, R2.y;
RCP R2.w, R2.w;
RCP R2.z, R2.z;
MAX R0, R0, c[36].z;
MUL R0, R0, R2;
MUL R2.xyz, R0.y, c[20];
MAD R2.xyz, R0.x, c[19], R2;
MAD R0.xyz, R0.z, c[21], R2;
MAD R2.xyz, R0.w, c[22], R0;
MUL R0, R8.xyzz, R8.yzzx;
MUL R2.w, R7, R7;
DP4 R5.z, R0, c[28];
DP4 R5.y, R0, c[27];
DP4 R5.x, R0, c[26];
MAD R2.w, R8.x, R8.x, -R2;
DP4 R4.z, R8, c[25];
DP4 R4.y, R8, c[24];
DP4 R4.x, R8, c[23];
MUL R0.xyz, R2.w, c[29];
ADD R4.xyz, R4, R5;
ADD R0.xyz, R4, R0;
ADD result.texcoord[2].xyz, R0, R2;
ADD result.texcoord[3].xyz, -R7, c[14];
DP4 result.position.w, R1, c[4];
DP4 result.position.z, R1, c[3];
DP4 result.position.y, R1, c[2];
DP4 result.position.x, R1, c[1];
MOV result.texcoord[1].z, R3.x;
MOV result.texcoord[1].y, R7.w;
MOV result.texcoord[1].x, R8;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[32], c[32].zwzw;
END
# 90 instructions, 9 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_Time]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 17 [unity_4LightAtten0]
Vector 18 [unity_LightColor0]
Vector 19 [unity_LightColor1]
Vector 20 [unity_LightColor2]
Vector 21 [unity_LightColor3]
Vector 22 [unity_SHAr]
Vector 23 [unity_SHAg]
Vector 24 [unity_SHAb]
Vector 25 [unity_SHBr]
Vector 26 [unity_SHBg]
Vector 27 [unity_SHBb]
Vector 28 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 29 [unity_Scale]
Vector 30 [_Color]
Vector 31 [_MainTex_ST]
"vs_2_0
; 92 ALU
def c32, 2.00000000, 1.00000000, 6.40884876, -3.14159274
def c33, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c34, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c35, 0.02400000, 0.08000000, 0.20000000, -0.00019841
def c36, 0.00833330, -0.16161616, 0.00000000, 0
def c37, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c38, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c39, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.x, c30.z
mul r1.xyz, v0.z, c35
mad r0.x, c32, -r0, -v5.z
add r0.x, r0, c32.y
mov r8.w, c32.y
mad r1, v0.x, c34, r1.xyyz
add r0.y, v5, c30
mul r0.x, r0, c12
mul r0.x, r0, r0.y
mad r0, r0.x, c33, r1
frc r0, r0
mad r1, r0, c32.z, c32.w
mul r0, r1, r1
mul r2, r0, r1
mad r1, r2, c36.y, r1
mul r2, r2, r0
mad r1, r2, c36.x, r1
mul r0, r2, r0
mad r0, r0, c35.w, r1
add r3.x, v5.w, c30.w
mul r2.x, v3.y, r3
mul r0, r0, r2.x
mul r0, r0, c37
mul r0, r0, r0
mul r0, r0, r0
dp4 r1.z, r0, c38
dp4 r1.x, r0, c39
mov r1.y, c36.z
dp3 r0.y, r1, c10
dp3 r0.x, r1, c8
add r1.xz, v0, -r0.xyyw
mov r1.yw, v0
dp4 r7.xy, r1, c5
add r3, -r7.x, c15
dp4 r6.zw, r1, c6
dp4 r7.x, r1, c4
mov r7.z, r6.w
mul r0, r3, r3
add r2, -r7.x, c14
mad r4, r2, r2, r0
add r0, -r6.z, c16
mul r6.xyz, v2, c29.w
dp3 r7.w, r6, c5
mad r4, r0, r0, r4
dp3 r8.x, r6, c4
mul r3, r7.w, r3
mad r2, r8.x, r2, r3
dp3 r3.x, r6, c6
mad r0, r3.x, r0, r2
mul r5, r4, c17
mov r8.y, r7.w
mov r8.z, r3.x
rsq r2.x, r4.x
rsq r2.y, r4.y
rsq r2.z, r4.z
rsq r2.w, r4.w
mul r0, r0, r2
add r2, r5, c32.y
rcp r2.x, r2.x
rcp r2.y, r2.y
rcp r2.w, r2.w
rcp r2.z, r2.z
max r0, r0, c36.z
mul r0, r0, r2
mul r2.xyz, r0.y, c19
mad r2.xyz, r0.x, c18, r2
mad r0.xyz, r0.z, c20, r2
mad r2.xyz, r0.w, c21, r0
mul r0, r8.xyzz, r8.yzzx
mul r2.w, r7, r7
dp4 r5.z, r0, c27
dp4 r5.y, r0, c26
dp4 r5.x, r0, c25
mad r2.w, r8.x, r8.x, -r2
dp4 r4.z, r8, c24
dp4 r4.y, r8, c23
dp4 r4.x, r8, c22
mul r0.xyz, r2.w, c28
add r4.xyz, r4, r5
add r0.xyz, r4, r0
add oT2.xyz, r0, r2
add oT3.xyz, -r7, c13
dp4 oPos.w, r1, c3
dp4 oPos.z, r1, c2
dp4 oPos.y, r1, c1
dp4 oPos.x, r1, c0
mov oT1.z, r3.x
mov oT1.y, r7.w
mov oT1.x, r8
mad oT0.xy, v3, c31, c31.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 112 // 96 used size, 8 vars
Vector 64 [_Color] 4
Vector 80 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 0 [_Time] 4
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 32 [unity_4LightPosX0] 4
Vector 48 [unity_4LightPosY0] 4
Vector 64 [unity_4LightPosZ0] 4
Vector 80 [unity_4LightAtten0] 4
Vector 96 [unity_LightColor0] 4
Vector 112 [unity_LightColor1] 4
Vector 128 [unity_LightColor2] 4
Vector 144 [unity_LightColor3] 4
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 75 instructions, 6 temp regs, 0 temp arrays:
// ALU 45 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddngpelbanfeplfgbgfpmnckmeofpaohaabaaaaaaieamaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoiakaaaaeaaaabaa
lkacaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaabjaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadocbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacagaaaaaadiaaaaak
pcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedmaknhkddnaknhkddn
mnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaaaceaaaaakgjleedn
ipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaiadp
aaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaafaaaaaa
diaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaa
aaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaaaaaaaaaaaeaaaaaa
diaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaadcaaaaampcaabaaa
aaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdpjkjjjjea
egaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaap
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmneaekbfmneaekbfmnea
ekbfmneaaceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaahpcaabaaa
acaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaa
egaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
adaaaaaaaceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaaaaaaaaaa
diaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadiaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidmgfiiaidm
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaa
ehamfaljehamfaljehamfaljehamfaljegaobaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddoihiofmdpdiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaa
egaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdnbbaaaaak
bcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedmaknhcddnipmcpfln
kgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaaagiccaaaadaaaaaa
bcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaabaaaaaaaagaabaaa
aaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaa
aaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
afaaaaaaogikcaaaaaaaaaaaafaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaa
abaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaa
adaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaa
dgaaaaafhccabaaaacaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaaabaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaabcaaaaaa
egaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaabdaaaaaa
egaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaabeaaaaaa
egaobaaaabaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaa
abaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaabfaaaaaaegaobaaa
adaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaabgaaaaaaegaobaaa
adaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaabhaaaaaaegaobaaa
adaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaa
diaaaaahecaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaak
ecaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaackaabaiaebaaaaaa
aaaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaabiaaaaaakgakbaaa
aaaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaaadaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakncaabaaaaaaaaaaaagijcaaaadaaaaaa
amaaaaaaagaabaaaaaaaaaaaagajbaaaadaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaafgafbaaaaaaaaaaaigadbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajpcaabaaaadaaaaaaagaabaiaebaaaaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaaaaaaaaajpcaabaaaaeaaaaaafgafbaiaebaaaaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaafaaaaaafgafbaaaabaaaaaa
egaobaaaaeaaaaaadiaaaaahpcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaa
aeaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaa
egaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaadaaaaaaagaabaaa
abaaaaaaegaobaaaafaaaaaaaaaaaaajpcaabaaaafaaaaaakgakbaiaebaaaaaa
aaaaaaaaegiocaaaacaaaaaaaeaaaaaaaaaaaaajhccabaaaaeaaaaaaegacbaia
ebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaaaaaaaaaa
egaobaaaafaaaaaakgakbaaaabaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaa
abaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaaeaaaaaaeeaaaaaf
pcaabaaaadaaaaaaegaobaaaabaaaaaadcaaaaanpcaabaaaabaaaaaaegaobaaa
abaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpaoaaaaakpcaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
abaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
agaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaahhccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
doaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 112 // 96 used size, 8 vars
Vector 64 [_Color] 4
Vector 80 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 0 [_Time] 4
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 32 [unity_4LightPosX0] 4
Vector 48 [unity_4LightPosY0] 4
Vector 64 [unity_4LightPosZ0] 4
Vector 80 [unity_4LightAtten0] 4
Vector 96 [unity_LightColor0] 4
Vector 112 [unity_LightColor1] 4
Vector 128 [unity_LightColor2] 4
Vector 144 [unity_LightColor3] 4
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 75 instructions, 6 temp regs, 0 temp arrays:
// ALU 45 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_3
eefieceddemakhalkjgpgjgiiakjjjbhjpoeadlfabaaaaaaiibdaaaaaeaaaaaa
daaaaaaadaahaaaacabcaaaaoibcaaaaebgpgodjpiagaaaapiagaaaaaaacpopp
geagaaaajeaaaaaaajaaceaaaaaajaaaaaaajaaaaaaaceaaabaajaaaaaaaaeaa
acaaabaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaaabaaaeaaabaaaeaaaaaaaaaa
acaaacaaaiaaafaaaaaaaaaaacaabcaaahaaanaaaaaaaaaaadaaaaaaaeaabeaa
aaaaaaaaadaaamaaafaabiaaaaaaaaaaadaabcaaabaabnaaaaaaaaaaadaabeaa
abaaboaaaaaaaaaaaaaaaaaaabacpoppfbaaaaafbpaaapkakgjleednipmchfdn
ipmchfdokgjlmednfbaaaaafcaaaapkakgjlmedmaknhkddnmnmmemdolfhocflo
fbaaaaafcbaaapkaaaaaaaeaaaaaiadpekbfmneanlapejmafbaaaaafccaaapka
jkjjjjdpaaaaaaeamnmmmmdpjkjjjjeafbaaaaafcdaaapkagfiiaidmehamfalj
aaaaaaaaaaaaaaaafbaaaaafceaaapkaihiofmdoblmmlhdokpajjddoihiofmdp
fbaaaaafcfaaapkakgjlmedmaknhcddnipmcpflnkgjlmednfbaaaaafcgaaapka
kgjlmedlaknhkddmaknhkdlmmnmmmmdnbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaafiaafaaapja
aeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaafaaaaadaaaaapiaaaaakkja
caaajekaaeaaaaaeaaaaapiaaaaaaajabpaaoekaaaaaoeiaabaaaaacabaaadia
cbaaoekaaeaaaaaeabaaabiaabaakkkaabaaaaibabaaffiaacaaaaadabaaabia
abaaaaiaafaakkjbafaaaaadabaaabiaabaaaaiaadaaaakaacaaaaadabaaamia
afaanejaabaanekaafaaaaadabaaabiaabaakkiaabaaaaiaafaaaaadabaaaeia
abaappiaadaaffjaaeaaaaaeaaaaapiaabaaaaiaccaaoekaaaaaoeiabdaaaaac
aaaaapiaaaaaoeiaaeaaaaaeaaaaapiaaaaaoeiacbaakkkacbaappkaafaaaaad
acaaapiaaaaaoeiaaaaaoeiaafaaaaadadaaapiaaaaaoeiaacaaoeiaaeaaaaae
aaaaapiaadaaoeiacaaappkaaaaaoeiaafaaaaadadaaapiaacaaoeiaadaaoeia
afaaaaadacaaapiaacaaoeiaadaaoeiaaeaaaaaeaaaaapiaadaaoeiacdaaaaka
aaaaoeiaaeaaaaaeaaaaapiaacaaoeiacdaaffkaaaaaoeiaafaaaaadaaaaapia
abaakkiaaaaaoeiaafaaaaadaaaaapiaaaaaoeiaceaaoekaafaaaaadaaaaapia
aaaaoeiaaaaaoeiaafaaaaadaaaaapiaaaaaoeiaaaaaoeiaajaaaaadabaaabia
aaaaoeiacgaaoekaajaaaaadaaaaabiaaaaaoeiacfaaoekaafaaaaadaaaaagia
abaaaaiabnaaoakaaeaaaaaeaaaaadiabmaaoikaaaaaaaiaaaaaojiaacaaaaad
aaaaadiaaaaaoeibaaaaoijaafaaaaadabaaaniaaaaaffjabjaajekaaeaaaaae
abaaaniabiaajekaaaaaaaiaabaaoeiaaeaaaaaeabaaaniabkaajekaaaaaffia
abaaoeiaaeaaaaaeabaaaniablaajekaaaaappjaabaaoeiaacaaaaadadaaahoa
abaapiibaeaaoekaacaaaaadacaaapiaabaakkibagaaoekaafaaaaadadaaapia
acaaoeiaacaaoeiaacaaaaadaeaaapiaabaaaaibafaaoekaacaaaaadafaaapia
abaappibahaaoekaaeaaaaaeadaaapiaaeaaoeiaaeaaoeiaadaaoeiaaeaaaaae
adaaapiaafaaoeiaafaaoeiaadaaoeiaahaaaaacagaaabiaadaaaaiaahaaaaac
agaaaciaadaaffiaahaaaaacagaaaeiaadaakkiaahaaaaacagaaaiiaadaappia
aeaaaaaeabaaapiaadaaoeiaaiaaoekaabaaffiaafaaaaadadaaahiaacaaoeja
boaappkaafaaaaadahaaahiaadaaffiabjaaoekaaeaaaaaeadaaaliabiaakeka
adaaaaiaahaakeiaaeaaaaaeadaaahiabkaaoekaadaakkiaadaapeiaafaaaaad
acaaapiaacaaoeiaadaaffiaaeaaaaaeacaaapiaaeaaoeiaadaaaaiaacaaoeia
aeaaaaaeacaaapiaafaaoeiaadaakkiaacaaoeiaafaaaaadacaaapiaagaaoeia
acaaoeiaalaaaaadacaaapiaacaaoeiacdaakkkaagaaaaacaeaaabiaabaaaaia
agaaaaacaeaaaciaabaaffiaagaaaaacaeaaaeiaabaakkiaagaaaaacaeaaaiia
abaappiaafaaaaadabaaapiaacaaoeiaaeaaoeiaafaaaaadacaaahiaabaaffia
akaaoekaaeaaaaaeacaaahiaajaaoekaabaaaaiaacaaoeiaaeaaaaaeabaaahia
alaaoekaabaakkiaacaaoeiaaeaaaaaeabaaahiaamaaoekaabaappiaabaaoeia
abaaaaacadaaaiiacbaaffkaajaaaaadacaaabiaanaaoekaadaaoeiaajaaaaad
acaaaciaaoaaoekaadaaoeiaajaaaaadacaaaeiaapaaoekaadaaoeiaafaaaaad
aeaaapiaadaacjiaadaakeiaajaaaaadafaaabiabaaaoekaaeaaoeiaajaaaaad
afaaaciabbaaoekaaeaaoeiaajaaaaadafaaaeiabcaaoekaaeaaoeiaacaaaaad
acaaahiaacaaoeiaafaaoeiaafaaaaadaaaaaeiaadaaffiaadaaffiaaeaaaaae
aaaaaeiaadaaaaiaadaaaaiaaaaakkibabaaaaacabaaahoaadaaoeiaaeaaaaae
acaaahiabdaaoekaaaaakkiaacaaoeiaacaaaaadacaaahoaabaaoeiaacaaoeia
afaaaaadabaaapiaaaaaffjabfaaoekaaeaaaaaeabaaapiabeaaoekaaaaaaaia
abaaoeiaaeaaaaaeaaaaapiabgaaoekaaaaaffiaabaaoeiaaeaaaaaeaaaaapia
bhaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiappppaaaafdeieefcoiakaaaaeaaaabaalkacaaaa
fjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaabjaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaadocbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacagaaaaaadiaaaaakpcaabaaa
aaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedmaknhkddnaknhkddnmnmmemdo
dcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaaaceaaaaakgjleednipmchfdn
ipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaackiacaia
ebaaaaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaiadpaaaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaafaaaaaadiaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaaaaaaaaai
gcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaaaaaaaaaaaeaaaaaadiaaaaah
bcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaa
abaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaadcaaaaampcaabaaaaaaaaaaa
agaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdpjkjjjjeaegaobaaa
aaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaappcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmneaekbfmneaekbfmneaekbfmnea
aceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaahpcaabaaaacaaaaaa
egaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaa
aaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaa
aceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaaaaaaaaaadiaaaaah
pcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaa
acaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidmgfiiaidmegaobaaa
aaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaaehamfalj
ehamfaljehamfaljehamfaljegaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
fgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddoihiofmdpdiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaaegaobaaa
aaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdnbbaaaaakbcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedmaknhcddnipmcpflnkgjlmedn
diaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaaagiccaaaadaaaaaabcaaaaaa
dcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaabaaaaaaaagaabaaaaaaaaaaa
jgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaa
igbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaa
ogikcaaaaaaaaaaaafaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaa
pgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaa
amaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaaf
hccabaaaacaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
aaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaabcaaaaaaegaobaaa
abaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaabdaaaaaaegaobaaa
abaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaabeaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaa
bbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaabfaaaaaaegaobaaaadaaaaaa
bbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaabgaaaaaaegaobaaaadaaaaaa
bbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaabhaaaaaaegaobaaaadaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaah
ecaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakecaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaabiaaaaaakgakbaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaaihcaabaaaadaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakncaabaaaaaaaaaaaagijcaaaadaaaaaaamaaaaaa
agaabaaaaaaaaaaaagajbaaaadaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaafgafbaaaaaaaaaaaigadbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajpcaabaaaadaaaaaaagaabaiaebaaaaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaaaaaaaaajpcaabaaaaeaaaaaafgafbaiaebaaaaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaadiaaaaahpcaabaaaafaaaaaafgafbaaaabaaaaaaegaobaaa
aeaaaaaadiaaaaahpcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaa
dcaaaaajpcaabaaaaeaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaegaobaaa
aeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaadaaaaaaagaabaaaabaaaaaa
egaobaaaafaaaaaaaaaaaaajpcaabaaaafaaaaaakgakbaiaebaaaaaaaaaaaaaa
egiocaaaacaaaaaaaeaaaaaaaaaaaaajhccabaaaaeaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaaaaaaaaaaegaobaaa
afaaaaaakgakbaaaabaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaaabaaaaaa
egaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaaeaaaaaaeeaaaaafpcaabaaa
adaaaaaaegaobaaaabaaaaaadcaaaaanpcaabaaaabaaaaaaegaobaaaabaaaaaa
egiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
aoaaaaakpcaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
egaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
adaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
acaaaaaaahaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaagaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaahhccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
kjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaoaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 13 [_Time]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_ProjectionParams]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 31 [unity_Scale]
Vector 32 [_Color]
Vector 33 [_MainTex_ST]
"!!ARBvp1.0
# 96 ALU
PARAM c[41] = { { 2, 1, 6.4088488, 3.1415927 },
		state.matrix.mvp,
		program.local[5..33],
		{ 1.2, 2, 1.6, 4.8000002 },
		{ 0.048, 0.059999999, 0.23999999, 0.096000001 },
		{ 0.024, 0.079999998, 0.2, -0.00019840999 },
		{ 0.0083333002, -0.16161616, 0, 0.5 },
		{ 0.21538745, 0.35897908, 0.28718325, 0.86154979 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
MOV R0.x, c[0];
MUL R1.xyz, vertex.position.z, c[36];
MAD R0.x, R0, -c[32].z, -vertex.color.z;
ADD R0.x, R0, c[0].y;
MOV R7.w, c[0].y;
MAD R1, vertex.position.x, c[35], R1.xyyz;
ADD R0.y, vertex.color, c[32];
MUL R0.x, R0, c[13];
MUL R0.x, R0, R0.y;
MAD R0, R0.x, c[34], R1;
FRC R0, R0;
MAD R1, R0, c[0].z, -c[0].w;
MUL R0, R1, R1;
MUL R2, R0, R1;
MAD R1, R2, c[37].y, R1;
MUL R2, R2, R0;
MAD R1, R2, c[37].x, R1;
MUL R0, R2, R0;
MAD R0, R0, c[36].w, R1;
ADD R3.x, vertex.color.w, c[32].w;
MUL R2.x, vertex.texcoord[0].y, R3;
MUL R0, R0, R2.x;
MUL R0, R0, c[38];
MUL R0, R0, R0;
MUL R0, R0, R0;
DP4 R1.z, R0, c[39];
DP4 R1.x, R0, c[40];
MOV R1.y, c[37].z;
DP3 R0.y, R1, c[11];
DP3 R0.x, R1, c[9];
ADD R1.xz, vertex.position, -R0.xyyw;
MOV R1.yw, vertex.position;
DP4 R8.xy, R1, c[6];
ADD R3, -R8.x, c[17];
DP4 R6.zw, R1, c[7];
DP4 R8.x, R1, c[5];
MOV R8.z, R6.w;
MUL R0, R3, R3;
ADD R2, -R8.x, c[16];
MAD R4, R2, R2, R0;
ADD R0, -R6.z, c[18];
MUL R6.xyz, vertex.normal, c[31].w;
DP3 R8.w, R6, c[6];
DP3 R7.x, R6, c[5];
MAD R4, R0, R0, R4;
MUL R3, R8.w, R3;
MAD R2, R7.x, R2, R3;
DP3 R3.w, R6, c[7];
MAD R0, R3.w, R0, R2;
MUL R5, R4, c[19];
MOV R7.y, R8.w;
MOV R7.z, R3.w;
RSQ R2.x, R4.x;
RSQ R2.y, R4.y;
RSQ R2.z, R4.z;
RSQ R2.w, R4.w;
MUL R0, R0, R2;
ADD R2, R5, c[0].y;
RCP R2.x, R2.x;
RCP R2.y, R2.y;
RCP R2.w, R2.w;
RCP R2.z, R2.z;
MAX R0, R0, c[37].z;
MUL R0, R0, R2;
MUL R2.xyz, R0.y, c[21];
MAD R2.xyz, R0.x, c[20], R2;
MAD R0.xyz, R0.z, c[22], R2;
MAD R4.xyz, R0.w, c[23], R0;
MUL R0, R7.xyzz, R7.yzzx;
MUL R2.z, R8.w, R8.w;
DP4 R2.w, R1, c[4];
DP4 R2.x, R1, c[1];
DP4 R2.y, R1, c[2];
MUL R3.xyz, R2.xyww, c[37].w;
DP4 R6.z, R0, c[29];
DP4 R6.y, R0, c[28];
MAD R2.z, R7.x, R7.x, -R2;
DP4 R6.x, R0, c[27];
MUL R0.xyz, R2.z, c[30];
DP4 R2.z, R1, c[3];
DP4 R5.z, R7, c[26];
DP4 R5.y, R7, c[25];
DP4 R5.x, R7, c[24];
ADD R5.xyz, R5, R6;
ADD R0.xyz, R5, R0;
ADD result.texcoord[2].xyz, R0, R4;
MOV R0.x, R3;
MUL R0.y, R3, c[15].x;
ADD result.texcoord[4].xy, R0, R3.z;
MOV result.position, R2;
MOV result.texcoord[4].zw, R2;
ADD result.texcoord[3].xyz, -R8, c[14];
MOV result.texcoord[1].z, R3.w;
MOV result.texcoord[1].y, R8.w;
MOV result.texcoord[1].x, R7;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[33], c[33].zwzw;
END
# 96 instructions, 9 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_Time]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_ScreenParams]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 31 [unity_Scale]
Vector 32 [_Color]
Vector 33 [_MainTex_ST]
"vs_2_0
; 98 ALU
def c34, 2.00000000, 1.00000000, 6.40884876, -3.14159274
def c35, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c36, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c37, 0.02400000, 0.08000000, 0.20000000, -0.00019841
def c38, 0.00833330, -0.16161616, 0.00000000, 0.50000000
def c39, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c40, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c41, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.x, c32.z
mul r1.xyz, v0.z, c37
mad r0.x, c34, -r0, -v5.z
add r0.x, r0, c34.y
mov r7.w, c34.y
mad r1, v0.x, c36, r1.xyyz
add r0.y, v5, c32
mul r0.x, r0, c12
mul r0.x, r0, r0.y
mad r0, r0.x, c35, r1
frc r0, r0
mad r1, r0, c34.z, c34.w
mul r0, r1, r1
mul r2, r0, r1
mad r1, r2, c38.y, r1
mul r2, r2, r0
mad r1, r2, c38.x, r1
mul r0, r2, r0
mad r0, r0, c37.w, r1
add r3.x, v5.w, c32.w
mul r2.x, v3.y, r3
mul r0, r0, r2.x
mul r0, r0, c39
mul r0, r0, r0
mul r0, r0, r0
dp4 r1.z, r0, c40
dp4 r1.x, r0, c41
mov r1.y, c38.z
dp3 r0.y, r1, c10
dp3 r0.x, r1, c8
add r1.xz, v0, -r0.xyyw
mov r1.yw, v0
dp4 r8.xy, r1, c5
add r3, -r8.x, c17
dp4 r6.zw, r1, c6
dp4 r8.x, r1, c4
mov r8.z, r6.w
mul r0, r3, r3
add r2, -r8.x, c16
mad r4, r2, r2, r0
add r0, -r6.z, c18
mul r6.xyz, v2, c31.w
dp3 r8.w, r6, c5
dp3 r7.x, r6, c4
mad r4, r0, r0, r4
mul r3, r8.w, r3
mad r2, r7.x, r2, r3
dp3 r3.w, r6, c6
mad r0, r3.w, r0, r2
mul r5, r4, c19
mov r7.y, r8.w
mov r7.z, r3.w
rsq r2.x, r4.x
rsq r2.y, r4.y
rsq r2.z, r4.z
rsq r2.w, r4.w
mul r0, r0, r2
add r2, r5, c34.y
rcp r2.x, r2.x
rcp r2.y, r2.y
rcp r2.w, r2.w
rcp r2.z, r2.z
max r0, r0, c38.z
mul r0, r0, r2
mul r2.xyz, r0.y, c21
mad r2.xyz, r0.x, c20, r2
mad r0.xyz, r0.z, c22, r2
mad r4.xyz, r0.w, c23, r0
mul r0, r7.xyzz, r7.yzzx
mul r2.z, r8.w, r8.w
dp4 r2.w, r1, c3
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
mul r3.xyz, r2.xyww, c38.w
dp4 r6.z, r0, c29
dp4 r6.y, r0, c28
mad r2.z, r7.x, r7.x, -r2
dp4 r6.x, r0, c27
mul r0.xyz, r2.z, c30
dp4 r2.z, r1, c2
dp4 r5.z, r7, c26
dp4 r5.y, r7, c25
dp4 r5.x, r7, c24
add r5.xyz, r5, r6
add r0.xyz, r5, r0
add oT2.xyz, r0, r4
mov r0.x, r3
mul r0.y, r3, c14.x
mad oT4.xy, r3.z, c15.zwzw, r0
mov oPos, r2
mov oT4.zw, r2
add oT3.xyz, -r8, c13
mov oT1.z, r3.w
mov oT1.y, r8.w
mov oT1.x, r7
mad oT0.xy, v3, c33, c33.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 176 // 160 used size, 9 vars
Vector 128 [_Color] 4
Vector 144 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 0 [_Time] 4
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 32 [unity_4LightPosX0] 4
Vector 48 [unity_4LightPosY0] 4
Vector 64 [unity_4LightPosZ0] 4
Vector 80 [unity_4LightAtten0] 4
Vector 96 [unity_LightColor0] 4
Vector 112 [unity_LightColor1] 4
Vector 128 [unity_LightColor2] 4
Vector 144 [unity_LightColor3] 4
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 81 instructions, 7 temp regs, 0 temp arrays:
// ALU 49 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedlpigfhhbnggknjjdkjmfeafillfalpioabaaaaaafaanaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcjmalaaaaeaaaabaaohacaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaabjaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadocbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacahaaaaaa
diaaaaakpcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedmaknhkddn
aknhkddnmnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaaaceaaaaa
kgjleednipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaalbcaabaaa
abaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeaabeaaaaa
aaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaa
afaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaabaaaaaa
aaaaaaaaaaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaaaaaaaaaa
aiaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaadcaaaaam
pcaabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdp
jkjjjjeaegaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmneaekbfmnea
ekbfmneaekbfmneaaceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaah
pcaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
adaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaadaaaaaaaceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaa
aaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaa
diaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidm
gfiiaidmegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaa
aceaaaaaehamfaljehamfaljehamfaljehamfaljegaobaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddoihiofmdp
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaakbcaabaaa
abaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdn
bbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedmaknhcddn
ipmcpflnkgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaaagiccaaa
adaaaaaabcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaabaaaaaaa
agaabaaaaaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaia
ebaaaaaaaaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaa
aaaaaaaaajaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaaacaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaacaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaacaaaaaaegaibaaaadaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaacaaaaaaegadbaaaacaaaaaadgaaaaafhccabaaa
acaaaaaaegacbaaaacaaaaaadgaaaaaficaabaaaacaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaabcaaaaaaegaobaaaacaaaaaa
bbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaabdaaaaaaegaobaaaacaaaaaa
bbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaabeaaaaaaegaobaaaacaaaaaa
diaaaaahpcaabaaaaeaaaaaajgacbaaaacaaaaaaegakbaaaacaaaaaabbaaaaai
bcaabaaaafaaaaaaegiocaaaacaaaaaabfaaaaaaegaobaaaaeaaaaaabbaaaaai
ccaabaaaafaaaaaaegiocaaaacaaaaaabgaaaaaaegaobaaaaeaaaaaabbaaaaai
ecaabaaaafaaaaaaegiocaaaacaaaaaabhaaaaaaegaobaaaaeaaaaaaaaaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaafaaaaaadiaaaaahecaabaaa
aaaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakecaabaaaaaaaaaaa
akaabaaaacaaaaaaakaabaaaacaaaaaackaabaiaebaaaaaaaaaaaaaadcaaaaak
hcaabaaaadaaaaaaegiccaaaacaaaaaabiaaaaaakgakbaaaaaaaaaaaegacbaaa
adaaaaaadiaaaaaihcaabaaaaeaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakncaabaaaaaaaaaaaagijcaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaagajbaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaafgafbaaaaaaaaaaaigadbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
pcaabaaaaeaaaaaaagaabaiaebaaaaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
aaaaaaajpcaabaaaafaaaaaafgafbaiaebaaaaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaadiaaaaahpcaabaaaagaaaaaafgafbaaaacaaaaaaegaobaaaafaaaaaa
diaaaaahpcaabaaaafaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaadcaaaaaj
pcaabaaaafaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaaafaaaaaa
dcaaaaajpcaabaaaaeaaaaaaegaobaaaaeaaaaaaagaabaaaacaaaaaaegaobaaa
agaaaaaaaaaaaaajpcaabaaaagaaaaaakgakbaiaebaaaaaaaaaaaaaaegiocaaa
acaaaaaaaeaaaaaaaaaaaaajhccabaaaaeaaaaaaegacbaiaebaaaaaaaaaaaaaa
egiccaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaaaaaaaaaaegaobaaaagaaaaaa
kgakbaaaacaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaa
agaaaaaaegaobaaaagaaaaaaegaobaaaafaaaaaaeeaaaaafpcaabaaaaeaaaaaa
egaobaaaacaaaaaadcaaaaanpcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaa
acaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaak
pcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaa
acaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaeaaaaaa
deaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaa
aaaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaa
ahaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aiaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaajaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaah
hccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaadiaaaaaibcaabaaa
aaaaaaaabkaabaaaabaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaaaaaaaaaa
agadbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaadgaaaaaf
mccabaaaafaaaaaakgaobaaaabaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaa
aaaaaaaamgaabaaaaaaaaaaadoaaaaab"
}

}
Program "fp" {
// Fragment combos: 4
//   opengl - ALU: 8 to 25, TEX: 1 to 3
//   d3d9 - ALU: 8 to 25, TEX: 2 to 4
//   d3d11 - ALU: 5 to 16, TEX: 1 to 3, FLOW: 1 to 1
//   d3d11_9x - ALU: 5 to 15, TEX: 1 to 2, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_VertexLitTranslucencyColor]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 22 ALU, 1 TEX
PARAM c[6] = { program.local[0..3],
		{ 4, 0, 0.85009766, 0.099975586 },
		{ 0.70019531, 0.30004883, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
DP3 R1.w, fragment.texcoord[1], c[0];
SLT R1.x, R0.w, c[3];
MOV_SAT R2.w, -R1;
MUL R2.xyz, R0, fragment.texcoord[2];
MOV result.color.w, R0;
KIL -R1.x;
DP3 R1.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R1.x, R1.x;
MUL R1.xyz, R1.x, fragment.texcoord[3];
DP3_SAT R1.x, R1, -c[0];
ADD R1.y, R1.x, -R2.w;
MAD R1.z, R1.w, c[5].x, c[5].y;
ADD R1.x, R0.y, -c[4].w;
MAD R1.y, R1, c[4].z, R2.w;
MAX R1.w, R1.z, c[4].y;
MUL R1.x, R1.y, R1;
MUL R1.xyz, R1.x, c[2];
MAD R1.xyz, R1, c[4].x, R1.w;
MUL R0.xyz, R0, c[1];
MUL R0.xyz, R0, R1;
MAD result.color.xyz, R0, c[5].z, R2;
END
# 22 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_VertexLitTranslucencyColor]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 23 ALU, 2 TEX
dcl_2d s0
def c4, 0.00000000, 1.00000000, 0.70019531, 0.30004883
def c5, -0.09997559, 0.85009766, 4.00000000, 2.00000000
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r4, t0, s0
add_pp r0.x, r4.w, -c3
cmp r0.x, r0, c4, c4.y
mov_pp r0, -r0.x
mul_pp r5.xyz, r4, t2
texkill r0.xyzw
dp3_pp r0.x, t3, t3
rsq_pp r1.x, r0.x
mul_pp r2.xyz, r1.x, t3
dp3_pp r0.x, t1, c0
mov_pp_sat r1.x, -r0
dp3_pp_sat r2.x, r2, -c0
add_pp r3.x, r2, -r1
mad_pp r0.x, r0, c4.z, c4.w
add_pp r2.x, r4.y, c5
mad_pp r1.x, r3, c5.y, r1
mul_pp r1.x, r1, r2
mul_pp r1.xyz, r1.x, c2
max_pp r0.x, r0, c4
mad_pp r0.xyz, r1, c5.z, r0.x
mul_pp r1.xyz, r4, c1
mul_pp r0.xyz, r1, r0
mad_pp r0.xyz, r0, c5.w, r5
mov_pp r0.w, r4
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 112 // 100 used size, 8 vars
Vector 16 [_LightColor0] 4
Vector 48 [_VertexLitTranslucencyColor] 3
Float 96 [_Cutoff]
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
SetTexture 0 [_MainTex] 2D 0
// 24 instructions, 3 temp regs, 0 temp arrays:
// ALU 15 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedlillepincmfdadakmimkajbnjiclhgoaabaaaaaaeiaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefceaadaaaaeaaaaaaanaaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaa
dkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaagaaaaaadbaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
abaaaaaaegbcbaaaaeaaaaaabacaaaajbcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaiaebaaaaaaabaaaaaaaaaaaaaabaaaaaaiccaabaaaabaaaaaaegbcbaaa
acaaaaaaegiccaaaabaaaaaaaaaaaaaadgcaaaagecaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
dddddddpabeaaaaajkjjjjdodeaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaaaaaaaaaaaaibcaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaa
akaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
jkjjfjdpckaabaaaabaaaaaaaaaaaaahecaabaaaabaaaaaabkaabaaaaaaaaaaa
abeaaaaamnmmmmlndiaaaaahbcaabaaaabaaaaaackaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaaincaabaaaabaaaaaaagaabaaaabaaaaaaagijcaaaaaaaaaaa
adaaaaaadcaaaaamhcaabaaaabaaaaaaigadbaaaabaaaaaaaceaaaaaaaaaiaea
aaaaiaeaaaaaiaeaaaaaaaaafgafbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egbcbaaaadaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 112 // 100 used size, 8 vars
Vector 16 [_LightColor0] 4
Vector 48 [_VertexLitTranslucencyColor] 3
Float 96 [_Cutoff]
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
SetTexture 0 [_MainTex] 2D 0
// 24 instructions, 3 temp regs, 0 temp arrays:
// ALU 15 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_3
eefiecedbnlhplajaplagjgclklaannocngmafdbabaaaaaaemagaaaaaeaaaaaa
daaaaaaadaacaaaahiafaaaabiagaaaaebgpgodjpiabaaaapiabaaaaaaacpppp
kaabaaaafiaaaaaaaeaaciaaaaaafiaaaaaafiaaabaaceaaaaaafiaaaaaaaaaa
aaaaabaaabaaaaaaaaaaaaaaaaaaadaaabaaabaaaaaaaaaaaaaaagaaabaaacaa
aaaaaaaaabaaaaaaabaaadaaaaaaaaaaabacppppfbaaaaafaeaaapkajkjjfjdp
mnmmmmlndddddddpjkjjjjdofbaaaaafafaaapkaaaaaaaaaaaaaiaeaaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaiaabaachlabpaaaaac
aaaaaaiaacaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaacpiaaaaaoelaaaaioekaacaaaaadabaacpiaaaaappiaacaaaakb
ebaaaaababaaapiaceaaaaacabaachiaadaaoelaaiaaaaadabaadbiaabaaoeia
adaaoekbaiaaaaadabaacciaabaaoelaadaaoekaabaaaaacabaadeiaabaaffib
aeaaaaaeabaacciaabaaffiaaeaakkkaaeaappkaalaaaaadacaaciiaabaaffia
afaaaakabcaaaaaeacaacbiaaeaaaakaabaaaaiaabaakkiaacaaaaadabaacbia
aaaaffiaaeaaffkaafaaaaadabaacbiaabaaaaiaacaaaaiaafaaaaadabaachia
abaaaaiaabaaoekaaeaaaaaeabaachiaabaaoeiaafaaffkaacaappiaafaaaaad
acaachiaaaaaoeiaaaaaoekaafaaaaadabaachiaabaaoeiaacaaoeiaacaaaaad
abaachiaabaaoeiaabaaoeiaaeaaaaaeaaaachiaaaaaoeiaacaaoelaabaaoeia
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefceaadaaaaeaaaaaaanaaaaaaa
fjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaa
aaaaaaaaagaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
aeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaabacaaaaj
bcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaaaaaaaa
baaaaaaiccaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaa
dgcaaaagecaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaajccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaadddddddpabeaaaaajkjjjjdodeaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaaibcaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaajkjjfjdpckaabaaaabaaaaaaaaaaaaah
ecaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaamnmmmmlndiaaaaahbcaabaaa
abaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaincaabaaaabaaaaaa
agaabaaaabaaaaaaagijcaaaaaaaaaaaadaaaaaadcaaaaamhcaabaaaabaaaaaa
igadbaaaabaaaaaaaceaaaaaaaaaiaeaaaaaiaeaaaaaiaeaaaaaaaaafgafbaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
aaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheojiaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahahaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 8 ALU, 2 TEX
PARAM c[2] = { program.local[0],
		{ 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[1], 2D;
SLT R2.x, R0.w, c[0];
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[1].x;
MOV result.color.w, R0;
KIL -R2.x;
END
# 8 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [unity_Lightmap] 2D
"ps_2_0
; 8 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
def c1, 0.00000000, 1.00000000, 8.00000000, 0
dcl t0.xy
dcl t1.xy
texld r1, t0, s0
add_pp r0.x, r1.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r2, -r0.x
texld r0, t1, s1
texkill r2.xyzw
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c1.z
mov_pp r0.w, r1
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 128 // 116 used size, 9 vars
Float 112 [_Cutoff]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
// 10 instructions, 2 temp regs, 0 temp arrays:
// ALU 5 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedimgendapaiablgohjpiglhecbonaedoeabaaaaaafeacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefchmabaaaaeaaaaaaafpaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaajbcaabaaa
abaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaahaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 128 // 116 used size, 9 vars
Float 112 [_Cutoff]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
// 10 instructions, 2 temp regs, 0 temp arrays:
// ALU 5 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_3
eefiecedpklaneemnonggodbgbhpeekkodmnhjbnabaaaaaafmadaaaaaeaaaaaa
daaaaaaadeabaaaaliacaaaaciadaaaaebgpgodjpmaaaaaapmaaaaaaaaacpppp
meaaaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaahaaabaaaaaaaaaaaaaaabacppppfbaaaaafabaaapkaaaaaaaeb
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaadaaaacpiaaaaaoelaaaaioeka
acaaaaadabaacpiaaaaappiaaaaaaakbabaaaaacacaaadiaaaaaollaebaaaaab
abaaapiaecaaaaadabaacpiaacaaoeiaabaioekaafaaaaadabaaciiaabaappia
abaaaakaafaaaaadabaachiaabaaoeiaabaappiaafaaaaadaaaachiaaaaaoeia
abaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefchmabaaaaeaaaaaaa
fpaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaaj
bcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaahaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaabaaaaaaamamaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_VertexLitTranslucencyColor]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 25 ALU, 2 TEX
PARAM c[6] = { program.local[0..3],
		{ 4, 0, 0.85009766, 0.099975586 },
		{ 0.70019531, 0.30004883, 2, 0.79980469 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R1.x, R0.w, c[3];
DP3 R1.y, fragment.texcoord[3], fragment.texcoord[3];
RSQ R1.z, R1.y;
MUL R2.xyz, R1.z, fragment.texcoord[3];
DP3 R1.y, fragment.texcoord[1], c[0];
MOV_SAT R1.z, -R1.y;
DP3_SAT R1.w, R2, -c[0];
ADD R2.x, R1.w, -R1.z;
MAD R1.y, R1, c[5].x, c[5];
ADD R1.w, R0.y, -c[4];
MAD R1.z, R2.x, c[4], R1;
MUL R1.z, R1, R1.w;
MAX R1.y, R1, c[4];
MUL R2.xyz, R1.z, c[2];
MAD R2.xyz, R2, c[4].x, R1.y;
MUL R1.yzw, R0.xxyz, c[1].xxyz;
MUL R2.xyz, R1.yzww, R2;
MUL R0.xyz, R0, fragment.texcoord[2];
MOV result.color.w, R0;
KIL -R1.x;
TXP R1.x, fragment.texcoord[4], texture[1], 2D;
MAD R1.x, R1, c[5].z, -c[5].z;
MAD R1.x, R1, c[5].w, c[5].z;
MAD result.color.xyz, R2, R1.x, R0;
END
# 25 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_VertexLitTranslucencyColor]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"ps_2_0
; 25 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
def c4, 0.00000000, 1.00000000, 0.70019531, 0.30004883
def c5, -0.09997559, 0.85009766, 4.00000000, 2.00000000
def c6, 0.79980469, 2.00000000, 0, 0
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4
texld r4, t0, s0
texldp r5, t4, s1
add_pp r0.x, r4.w, -c3
cmp r0.x, r0, c4, c4.y
mov_pp r0, -r0.x
texkill r0.xyzw
dp3_pp r0.x, t3, t3
rsq_pp r1.x, r0.x
mul_pp r2.xyz, r1.x, t3
dp3_pp r0.x, t1, c0
mov_pp_sat r1.x, -r0
dp3_pp_sat r2.x, r2, -c0
add_pp r3.x, r2, -r1
mad_pp r0.x, r0, c4.z, c4.w
add_pp r2.x, r4.y, c5
mad_pp r1.x, r3, c5.y, r1
mul_pp r1.x, r1, r2
max_pp r0.x, r0, c4
mul_pp r1.xyz, r1.x, c2
mad_pp r1.xyz, r1, c5.z, r0.x
mul_pp r0.xyz, r4, c1
mul_pp r1.xyz, r0, r1
mad_pp r0.x, r5, c5.w, -c5.w
mul_pp r2.xyz, r4, t2
mad_pp r0.x, r0, c6, c6.y
mad_pp r0.xyz, r1, r0.x, r2
mov_pp r0.w, r4
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 176 // 164 used size, 9 vars
Vector 16 [_LightColor0] 4
Vector 112 [_VertexLitTranslucencyColor] 3
Float 160 [_Cutoff]
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
// 28 instructions, 3 temp regs, 0 temp arrays:
// ALU 16 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedbglhfhiccfdmogheihmcgneankanimhlabaaaaaabaafaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpaadaaaa
eaaaaaaapmaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaajbcaabaaaabaaaaaa
dkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaakaaaaaadbaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
abaaaaaaegbcbaaaaeaaaaaabacaaaajbcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaiaebaaaaaaabaaaaaaaaaaaaaabaaaaaaiccaabaaaabaaaaaaegbcbaaa
acaaaaaaegiccaaaabaaaaaaaaaaaaaadgcaaaagecaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
dddddddpabeaaaaajkjjjjdodeaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaaaaaaaaaaaaibcaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaa
akaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
jkjjfjdpckaabaaaabaaaaaaaaaaaaahecaabaaaabaaaaaabkaabaaaaaaaaaaa
abeaaaaamnmmmmlndiaaaaahbcaabaaaabaaaaaackaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaaincaabaaaabaaaaaaagaabaaaabaaaaaaagijcaaaaaaaaaaa
ahaaaaaadcaaaaamhcaabaaaabaaaaaaigadbaaaabaaaaaaaceaaaaaaaaaiaea
aaaaiaeaaaaaiaeaaaaaaaaafgafbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaa
afaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadcaaaaajicaabaaaabaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaaamadcaaaaajicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaamnmmemdpabeaaaaaaaaaaaeadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaadaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaa
abaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ShadowMapTexture] 2D
SetTexture 2 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 14 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[1], texture[2], 2D;
TXP R3.x, fragment.texcoord[2], texture[1], 2D;
SLT R1.x, R0.w, c[0];
MOV result.color.w, R0;
KIL -R1.x;
MUL R1.xyz, R2.w, R2;
MUL R2.xyz, R2, R3.x;
MUL R1.xyz, R1, c[1].x;
MUL R3.xyz, R1, R3.x;
MUL R2.xyz, R2, c[1].y;
MIN R1.xyz, R1, R2;
MAX R1.xyz, R1, R3;
MUL result.color.xyz, R0, R1;
END
# 14 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ShadowMapTexture] 2D
SetTexture 2 [unity_Lightmap] 2D
"ps_2_0
; 13 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.00000000, 1.00000000, 8.00000000, 2.00000000
dcl t0.xy
dcl t1.xy
dcl t2
texldp r1, t2, s1
texld r2, t0, s0
add_pp r0.x, r2.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
texld r0, t1, s2
mul_pp r3.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1.x
mul_pp r3.xyz, r3, c1.z
mul_pp r0.xyz, r0, c1.w
mul_pp r1.xyz, r3, r1.x
min_pp r0.xyz, r3, r0
max_pp r0.xyz, r0, r1
mul_pp r0.xyz, r2, r0
mov_pp r0.w, r2
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 192 // 180 used size, 10 vars
Float 176 [_Cutoff]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
SetTexture 2 [unity_Lightmap] 2D 2
// 17 instructions, 3 temp regs, 0 temp arrays:
// ALU 11 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedfbafiphihhbdkhijoakkkkljcmlgfnfmabaaaaaagaadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefchaacaaaaeaaaaaaajmaaaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaajbcaabaaa
abaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaalaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadiaaaaahocaabaaaabaaaaaafgafbaaaabaaaaaaagajbaaaacaaaaaa
diaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaaddaaaaahocaabaaa
abaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaadiaaaaahhcaabaaaacaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaadeaaaaahhcaabaaaabaaaaaajgahbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}

}
	}
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardAdd" }
		ZWrite Off Blend One One Fog { Color (0,0,0,0) }
		ColorMask RGB
Program "vp" {
// Vertex combos: 5
//   opengl - ALU: 45 to 50
//   d3d9 - ALU: 47 to 52
//   d3d11 - ALU: 24 to 27, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 24 to 27, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 17 [_Time]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 20 [unity_Scale]
Matrix 13 [_LightMatrix0]
Vector 21 [_Color]
Vector 22 [_MainTex_ST]
"!!ARBvp1.0
# 49 ALU
PARAM c[30] = { { 2, 1, 6.4088488, 3.1415927 },
		state.matrix.mvp,
		program.local[5..22],
		{ 1.2, 2, 1.6, 4.8000002 },
		{ 0.048, 0.059999999, 0.23999999, 0.096000001 },
		{ 0.024, 0.079999998, 0.2, -0.00019840999 },
		{ 0.0083333002, -0.16161616, 0 },
		{ 0.21538745, 0.35897908, 0.28718325, 0.86154979 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[0];
MAD R1.x, R0, -c[21].z, -vertex.color.z;
MUL R2.xyz, vertex.position.z, c[25];
ADD R1.x, R1, c[0].y;
MAD R0, vertex.position.x, c[24], R2.xyyz;
ADD R1.y, vertex.color, c[21];
MUL R1.x, R1, c[17];
MUL R1.x, R1, R1.y;
MAD R0, R1.x, c[23], R0;
FRC R0, R0;
MAD R0, R0, c[0].z, -c[0].w;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[26].y, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[26].x, R0;
MAD R0, R1, c[25].w, R0;
ADD R3.x, vertex.color.w, c[21].w;
MUL R2.x, vertex.texcoord[0].y, R3;
MUL R0, R0, R2.x;
MUL R0, R0, c[27];
MUL R0, R0, R0;
MUL R0, R0, R0;
DP4 R1.z, R0, c[28];
DP4 R1.x, R0, c[29];
MOV R1.y, c[26].z;
DP3 R0.y, R1, c[11];
DP3 R0.x, R1, c[9];
ADD R1.xz, vertex.position, -R0.xyyw;
MOV R1.yw, vertex.position;
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
DP4 R0.w, R1, c[8];
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
ADD result.texcoord[2].xyz, -R0, c[19];
ADD result.texcoord[3].xyz, -R0, c[18];
MUL R0.xyz, vertex.normal, c[20].w;
DP4 result.position.w, R1, c[4];
DP4 result.position.z, R1, c[3];
DP4 result.position.y, R1, c[2];
DP4 result.position.x, R1, c[1];
DP3 result.texcoord[1].z, R0, c[7];
DP3 result.texcoord[1].y, R0, c[6];
DP3 result.texcoord[1].x, R0, c[5];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
END
# 49 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_Time]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 19 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 20 [_Color]
Vector 21 [_MainTex_ST]
"vs_2_0
; 51 ALU
def c22, 2.00000000, 1.00000000, 6.40884876, -3.14159274
def c23, 0.02400000, 0.08000000, 0.20000000, -0.16161616
def c24, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c25, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c26, 0.00833330, -0.00019841, 0.00000000, 0
def c27, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c28, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c29, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.x, c20.z
mad r1.x, c22, -r0, -v5.z
mul r2.xyz, v0.z, c23
add r1.x, r1, c22.y
mad r0, v0.x, c24, r2.xyyz
add r1.y, v5, c20
mul r1.x, r1, c16
mul r1.x, r1, r1.y
mad r0, r1.x, c25, r0
frc r0, r0
mad r0, r0, c22.z, c22.w
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c23.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c26.x, r0
mad r0, r1, c26.y, r0
add r3.x, v5.w, c20.w
mul r2.x, v3.y, r3
mul r0, r0, r2.x
mul r0, r0, c27
mul r0, r0, r0
mul r0, r0, r0
dp4 r1.z, r0, c28
dp4 r1.x, r0, c29
mov r1.y, c26.z
dp3 r0.y, r1, c10
dp3 r0.x, r1, c8
add r1.xz, v0, -r0.xyyw
mov r1.yw, v0
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp4 r0.w, r1, c7
dp4 oT4.z, r0, c14
dp4 oT4.y, r0, c13
dp4 oT4.x, r0, c12
add oT2.xyz, -r0, c18
add oT3.xyz, -r0, c17
mul r0.xyz, v2, c19.w
dp4 oPos.w, r1, c3
dp4 oPos.z, r1, c2
dp4 oPos.y, r1, c1
dp4 oPos.x, r1, c0
dp3 oT1.z, r0, c6
dp3 oT1.y, r0, c5
dp3 oT1.x, r0, c4
mad oT0.xy, v3, c21, c21.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 176 // 160 used size, 9 vars
Matrix 48 [_LightMatrix0] 4
Vector 128 [_Color] 4
Vector 144 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 0 [_Time] 4
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 51 instructions, 4 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedomjginpkphkebjnjncncgoeoblchlkfkabaaaaaaliajaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcaeaiaaaaeaaaabaaabacaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadocbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaa
diaaaaakpcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedmaknhkddn
aknhkddnmnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaaaceaaaaa
kgjleednipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaalbcaabaaa
abaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeaabeaaaaa
aaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaa
afaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaabaaaaaa
aaaaaaaaaaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaaaaaaaaaa
aiaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaadcaaaaam
pcaabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdp
jkjjjjeaegaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmneaekbfmnea
ekbfmneaekbfmneaaceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaah
pcaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
adaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaadaaaaaaaceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaa
aaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaa
diaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidm
gfiiaidmegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaa
aceaaaaaehamfaljehamfaljehamfaljehamfaljegaobaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddoihiofmdp
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaakbcaabaaa
abaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdn
bbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedmaknhcddn
ipmcpflnkgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaaagiccaaa
adaaaaaabcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaabaaaaaaa
agaabaaaaaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaia
ebaaaaaaaaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaaabaaaaaa
egbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaa
fgafbaaaabaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaa
egiicaaaadaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaak
hccabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaj
hccabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaa
aaaaaaajhccabaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaabaaaaaa
aeaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaaaaaaaaa
agaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 176 // 160 used size, 9 vars
Matrix 48 [_LightMatrix0] 4
Vector 128 [_Color] 4
Vector 144 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 0 [_Time] 4
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 51 instructions, 4 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_3
eefiecedaflefoekohpboiickhlfflecgljnhcfeabaaaaaapeaoaaaaaeaaaaaa
daaaaaaagiafaaaaheanaaaadmaoaaaaebgpgodjdaafaaaadaafaaaaaaacpopp
jmaeaaaajeaaaaaaajaaceaaaaaajaaaaaaajaaaaaaaceaaabaajaaaaaaaadaa
aeaaabaaaaaaaaaaaaaaaiaaacaaafaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaa
abaaaeaaabaaaiaaaaaaaaaaacaaaaaaabaaajaaaaaaaaaaadaaaaaaaeaaakaa
aaaaaaaaadaaamaaafaaaoaaaaaaaaaaadaabcaaabaabdaaaaaaaaaaadaabeaa
abaabeaaaaaaaaaaaaaaaaaaabacpoppfbaaaaafbfaaapkakgjleednipmchfdn
ipmchfdokgjlmednfbaaaaafbgaaapkakgjlmedmaknhkddnmnmmemdolfhocflo
fbaaaaafbhaaapkaaaaaaaeaaaaaiadpekbfmneanlapejmafbaaaaafbiaaapka
jkjjjjdpaaaaaaeamnmmmmdpjkjjjjeafbaaaaafbjaaapkagfiiaidmehamfalj
aaaaaaaaaaaaaaaafbaaaaafbkaaapkaihiofmdoblmmlhdokpajjddoihiofmdp
fbaaaaafblaaapkakgjlmedmaknhcddnipmcpflnkgjlmednfbaaaaafbmaaapka
kgjlmedlaknhkddmaknhkdlmmnmmmmdnbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaafiaafaaapja
aeaaaaaeaaaaadoaadaaoejaagaaoekaagaaookaafaaaaadaaaaahiaacaaoeja
beaappkaafaaaaadabaaahiaaaaaffiaapaaoekaaeaaaaaeaaaaaliaaoaakeka
aaaaaaiaabaakeiaaeaaaaaeabaaahoabaaaoekaaaaakkiaaaaapeiaafaaaaad
aaaaapiaaaaakkjabgaajekaaeaaaaaeaaaaapiaaaaaaajabfaaoekaaaaaoeia
abaaaaacabaaadiabhaaoekaaeaaaaaeabaaabiaafaakkkaabaaaaibabaaffia
acaaaaadabaaabiaabaaaaiaafaakkjbafaaaaadabaaabiaabaaaaiaahaaaaka
acaaaaadabaaagiaafaapejaafaapekaafaaaaadabaaabiaabaaffiaabaaaaia
afaaaaadabaaaciaabaakkiaadaaffjaaeaaaaaeaaaaapiaabaaaaiabiaaoeka
aaaaoeiabdaaaaacaaaaapiaaaaaoeiaaeaaaaaeaaaaapiaaaaaoeiabhaakkka
bhaappkaafaaaaadacaaapiaaaaaoeiaaaaaoeiaafaaaaadadaaapiaaaaaoeia
acaaoeiaaeaaaaaeaaaaapiaadaaoeiabgaappkaaaaaoeiaafaaaaadadaaapia
acaaoeiaadaaoeiaafaaaaadacaaapiaacaaoeiaadaaoeiaaeaaaaaeaaaaapia
adaaoeiabjaaaakaaaaaoeiaaeaaaaaeaaaaapiaacaaoeiabjaaffkaaaaaoeia
afaaaaadaaaaapiaabaaffiaaaaaoeiaafaaaaadaaaaapiaaaaaoeiabkaaoeka
afaaaaadaaaaapiaaaaaoeiaaaaaoeiaafaaaaadaaaaapiaaaaaoeiaaaaaoeia
ajaaaaadabaaabiaaaaaoeiabmaaoekaajaaaaadaaaaabiaaaaaoeiablaaoeka
afaaaaadaaaaagiaabaaaaiabdaaoakaaeaaaaaeaaaaadiabcaaoikaaaaaaaia
aaaaojiaacaaaaadaaaaadiaaaaaoeibaaaaoijaafaaaaadabaaahiaaaaaffja
apaaoekaaeaaaaaeabaaahiaaoaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaahia
baaaoekaaaaaffiaabaaoeiaaeaaaaaeabaaahiabbaaoekaaaaappjaabaaoeia
acaaaaadacaaahoaabaaoeibajaaoekaacaaaaadadaaahoaabaaoeibaiaaoeka
afaaaaadabaaapiaaaaaffjaapaaoekaaeaaaaaeabaaapiaaoaaoekaaaaaaaia
abaaoeiaaeaaaaaeabaaapiabaaaoekaaaaaffiaabaaoeiaaeaaaaaeabaaapia
bbaaoekaaaaappjaabaaoeiaafaaaaadacaaahiaabaaffiaacaaoekaaeaaaaae
acaaahiaabaaoekaabaaaaiaacaaoeiaaeaaaaaeabaaahiaadaaoekaabaakkia
acaaoeiaaeaaaaaeaeaaahoaaeaaoekaabaappiaabaaoeiaafaaaaadabaaapia
aaaaffjaalaaoekaaeaaaaaeabaaapiaakaaoekaaaaaaaiaabaaoeiaaeaaaaae
aaaaapiaamaaoekaaaaaffiaabaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiappppaaaafdeieefcaeaiaaaaeaaaabaaabacaaaafjaaaaaeegiocaaa
aaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
ocbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaak
pcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedmaknhkddnaknhkddn
mnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaaaceaaaaakgjleedn
ipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaiadp
aaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaafaaaaaa
diaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaa
aaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaaaaaaaaaaaiaaaaaa
diaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaadcaaaaampcaabaaa
aaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdpjkjjjjea
egaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaap
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmneaekbfmneaekbfmnea
ekbfmneaaceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaahpcaabaaa
acaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaa
egaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
adaaaaaaaceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaaaaaaaaaa
diaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadiaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidmgfiiaidm
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaa
ehamfaljehamfaljehamfaljehamfaljegaobaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddoihiofmdpdiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaa
egaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdnbbaaaaak
bcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedmaknhcddnipmcpfln
kgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaaagiccaaaadaaaaaa
bcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaabaaaaaaaagaabaaa
aaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaa
aaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
ajaaaaaaogikcaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaa
abaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaa
adaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhccabaaa
acaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
fgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhccabaaa
adaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaaaaaaaaaj
hccabaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaabaaaaaaaeaaaaaa
diaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaa
fgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaaaaaaaaaagaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 13 [_Time]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 16 [unity_Scale]
Vector 17 [_Color]
Vector 18 [_MainTex_ST]
"!!ARBvp1.0
# 45 ALU
PARAM c[26] = { { 2, 1, 6.4088488, 3.1415927 },
		state.matrix.mvp,
		program.local[5..18],
		{ 1.2, 2, 1.6, 4.8000002 },
		{ 0.048, 0.059999999, 0.23999999, 0.096000001 },
		{ 0.024, 0.079999998, 0.2, -0.00019840999 },
		{ 0.0083333002, -0.16161616, 0 },
		{ 0.21538745, 0.35897908, 0.28718325, 0.86154979 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[0];
MAD R1.x, R0, -c[17].z, -vertex.color.z;
MUL R2.xyz, vertex.position.z, c[21];
ADD R1.x, R1, c[0].y;
MAD R0, vertex.position.x, c[20], R2.xyyz;
ADD R1.y, vertex.color, c[17];
MUL R1.x, R1, c[13];
MUL R1.x, R1, R1.y;
MAD R0, R1.x, c[19], R0;
FRC R0, R0;
MAD R0, R0, c[0].z, -c[0].w;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[22].y, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[22].x, R0;
ADD R3.x, vertex.color.w, c[17].w;
MAD R0, R1, c[21].w, R0;
MUL R2.x, vertex.texcoord[0].y, R3;
MUL R0, R0, R2.x;
MUL R0, R0, c[23];
MUL R0, R0, R0;
MUL R1, R0, R0;
DP4 R0.z, R1, c[24];
DP4 R0.x, R1, c[25];
MOV R0.y, c[22].z;
DP3 R1.y, R0, c[11];
DP3 R1.x, R0, c[9];
ADD R0.xz, vertex.position, -R1.xyyw;
MOV R0.yw, vertex.position;
DP4 R1.z, R0, c[7];
DP4 R1.x, R0, c[5];
DP4 R1.y, R0, c[6];
ADD result.texcoord[3].xyz, -R1, c[14];
MUL R1.xyz, vertex.normal, c[16].w;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
MOV result.texcoord[2].xyz, c[15];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
END
# 45 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_Time]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 15 [unity_Scale]
Vector 16 [_Color]
Vector 17 [_MainTex_ST]
"vs_2_0
; 47 ALU
def c18, 2.00000000, 1.00000000, 6.40884876, -3.14159274
def c19, 0.02400000, 0.08000000, 0.20000000, -0.16161616
def c20, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c21, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c22, 0.00833330, -0.00019841, 0.00000000, 0
def c23, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c24, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c25, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.x, c16.z
mad r1.x, c18, -r0, -v5.z
mul r2.xyz, v0.z, c19
add r1.x, r1, c18.y
mad r0, v0.x, c20, r2.xyyz
add r1.y, v5, c16
mul r1.x, r1, c12
mul r1.x, r1, r1.y
mad r0, r1.x, c21, r0
frc r0, r0
mad r0, r0, c18.z, c18.w
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c19.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c22.x, r0
add r3.x, v5.w, c16.w
mad r0, r1, c22.y, r0
mul r2.x, v3.y, r3
mul r0, r0, r2.x
mul r0, r0, c23
mul r0, r0, r0
mul r1, r0, r0
dp4 r0.z, r1, c24
dp4 r0.x, r1, c25
mov r0.y, c22.z
dp3 r1.y, r0, c10
dp3 r1.x, r0, c8
add r0.xz, v0, -r1.xyyw
mov r0.yw, v0
dp4 r1.z, r0, c6
dp4 r1.x, r0, c4
dp4 r1.y, r0, c5
add oT3.xyz, -r1, c13
mul r1.xyz, v2, c15.w
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
dp3 oT1.z, r1, c6
dp3 oT1.y, r1, c5
dp3 oT1.x, r1, c4
mov oT2.xyz, c14
mad oT0.xy, v3, c17, c17.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 112 // 96 used size, 8 vars
Vector 64 [_Color] 4
Vector 80 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 0 [_Time] 4
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 43 instructions, 4 temp regs, 0 temp arrays:
// ALU 24 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmcadckibehkcmnnbbcoglimljmhpjlbgabaaaaaafiaiaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefclmagaaaaeaaaabaa
kpabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadocbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaak
pcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedmaknhkddnaknhkddn
mnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaaaceaaaaakgjleedn
ipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaiadp
aaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaafaaaaaa
diaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaa
aaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaaaaaaaaaaaeaaaaaa
diaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaadcaaaaampcaabaaa
aaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdpjkjjjjea
egaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaap
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmneaekbfmneaekbfmnea
ekbfmneaaceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaahpcaabaaa
acaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaa
egaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
adaaaaaaaceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaaaaaaaaaa
diaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadiaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidmgfiiaidm
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaa
ehamfaljehamfaljehamfaljehamfaljegaobaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddoihiofmdpdiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaa
egaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdnbbaaaaak
bcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedmaknhcddnipmcpfln
kgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaaagiccaaaadaaaaaa
bcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaabaaaaaaaagaabaaa
aaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaa
aaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
afaaaaaaogikcaaaaaaaaaaaafaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaa
abaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaa
adaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhccabaaa
acaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaa
dgaaaaaghccabaaaadaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakncaabaaa
aaaaaaaaagijcaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaagajbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaafgafbaaaaaaaaaaa
igadbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaaeaaaaaaegacbaia
ebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 112 // 96 used size, 8 vars
Vector 64 [_Color] 4
Vector 80 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 0 [_Time] 4
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 43 instructions, 4 temp regs, 0 temp arrays:
// ALU 24 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_3
eefiecedclbcddbahkcomcdhjhnnoekikagiadamabaaaaaaomamaaaaaeaaaaaa
daaaaaaamaaeaaaaiealaaaaemamaaaaebgpgodjiiaeaaaaiiaeaaaaaaacpopp
aaaeaaaaiiaaaaaaaiaaceaaaaaaieaaaaaaieaaaaaaceaaabaaieaaaaaaaeaa
acaaabaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaaabaaaeaaabaaaeaaaaaaaaaa
acaaaaaaabaaafaaaaaaaaaaadaaaaaaaeaaagaaaaaaaaaaadaaamaaafaaakaa
aaaaaaaaadaabcaaabaaapaaaaaaaaaaadaabeaaabaabaaaaaaaaaaaaaaaaaaa
abacpoppfbaaaaafbbaaapkakgjleednipmchfdnipmchfdokgjlmednfbaaaaaf
bcaaapkakgjlmedmaknhkddnmnmmemdolfhocflofbaaaaafbdaaapkaaaaaaaea
aaaaiadpekbfmneanlapejmafbaaaaafbeaaapkajkjjjjdpaaaaaaeamnmmmmdp
jkjjjjeafbaaaaafbfaaapkagfiiaidmehamfaljaaaaaaaaaaaaaaaafbaaaaaf
bgaaapkaihiofmdoblmmlhdokpajjddoihiofmdpfbaaaaafbhaaapkakgjlmedm
aknhcddnipmcpflnkgjlmednfbaaaaafbiaaapkakgjlmedlaknhkddmaknhkdlm
mnmmmmdnbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaafiaafaaapjaaeaaaaaeaaaaadoaadaaoeja
acaaoekaacaaookaafaaaaadaaaaahiaacaaoejabaaappkaafaaaaadabaaahia
aaaaffiaalaaoekaaeaaaaaeaaaaaliaakaakekaaaaaaaiaabaakeiaaeaaaaae
abaaahoaamaaoekaaaaakkiaaaaapeiaafaaaaadaaaaapiaaaaakkjabcaajeka
aeaaaaaeaaaaapiaaaaaaajabbaaoekaaaaaoeiaabaaaaacabaaadiabdaaoeka
aeaaaaaeabaaabiaabaakkkaabaaaaibabaaffiaacaaaaadabaaabiaabaaaaia
afaakkjbafaaaaadabaaabiaabaaaaiaadaaaakaacaaaaadabaaagiaafaapeja
abaapekaafaaaaadabaaabiaabaaffiaabaaaaiaafaaaaadabaaaciaabaakkia
adaaffjaaeaaaaaeaaaaapiaabaaaaiabeaaoekaaaaaoeiabdaaaaacaaaaapia
aaaaoeiaaeaaaaaeaaaaapiaaaaaoeiabdaakkkabdaappkaafaaaaadacaaapia
aaaaoeiaaaaaoeiaafaaaaadadaaapiaaaaaoeiaacaaoeiaaeaaaaaeaaaaapia
adaaoeiabcaappkaaaaaoeiaafaaaaadadaaapiaacaaoeiaadaaoeiaafaaaaad
acaaapiaacaaoeiaadaaoeiaaeaaaaaeaaaaapiaadaaoeiabfaaaakaaaaaoeia
aeaaaaaeaaaaapiaacaaoeiabfaaffkaaaaaoeiaafaaaaadaaaaapiaabaaffia
aaaaoeiaafaaaaadaaaaapiaaaaaoeiabgaaoekaafaaaaadaaaaapiaaaaaoeia
aaaaoeiaafaaaaadaaaaapiaaaaaoeiaaaaaoeiaajaaaaadabaaabiaaaaaoeia
biaaoekaajaaaaadaaaaabiaaaaaoeiabhaaoekaafaaaaadaaaaagiaabaaaaia
apaaoakaaeaaaaaeaaaaadiaaoaaoikaaaaaaaiaaaaaojiaacaaaaadaaaaadia
aaaaoeibaaaaoijaafaaaaadabaaahiaaaaaffjaalaaoekaaeaaaaaeabaaahia
akaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaahiaamaaoekaaaaaffiaabaaoeia
aeaaaaaeabaaahiaanaaoekaaaaappjaabaaoeiaacaaaaadadaaahoaabaaoeib
aeaaoekaafaaaaadabaaapiaaaaaffjaahaaoekaaeaaaaaeabaaapiaagaaoeka
aaaaaaiaabaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaaffiaabaaoeiaaeaaaaae
aaaaapiaajaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaahoaafaaoekappppaaaa
fdeieefclmagaaaaeaaaabaakpabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadocbabaaaafaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
giaaaaacaeaaaaaadiaaaaakpcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaa
kgjlmedmaknhkddnaknhkddnmnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaa
aaaaaaaaaceaaaaakgjleednipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaa
dcaaaaalbcaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaabeaaaaa
aaaaaaeaabeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
ckbabaiaebaaaaaaafaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
akiacaaaabaaaaaaaaaaaaaaaaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaa
fgihcaaaaaaaaaaaaeaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaa
adaaaaaadcaaaaampcaabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdp
aaaaaaeamnmmmmdpjkjjjjeaegaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
ekbfmneaekbfmneaekbfmneaekbfmneaaceaaaaanlapejmanlapejmanlapejma
nlapejmadiaaaaahpcaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaahpcaabaaaadaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaalfhocflolfhocflolfhocflo
lfhocfloegaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaadaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
adaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidm
gfiiaidmgfiiaidmgfiiaidmegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaacaaaaaaaceaaaaaehamfaljehamfaljehamfaljehamfaljegaobaaa
aaaaaaaadiaaaaahpcaabaaaaaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdo
kpajjddoihiofmdpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaa
bbaaaaakbcaabaaaabaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddm
aknhkdlmmnmmmmdnbbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
kgjlmedmaknhcddnipmcpflnkgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaa
abaaaaaaagiccaaaadaaaaaabcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaa
adaaaaaabaaaaaaaagaabaaaaaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaa
aaaaaaaaegaabaiaebaaaaaaaaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaafgafbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadiaaaaai
hcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaai
hcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
lcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaa
acaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaa
abaaaaaaegadbaaaabaaaaaadgaaaaaghccabaaaadaaaaaaegiccaaaacaaaaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakncaabaaaaaaaaaaaagijcaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaagajbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaafgafbaaaaaaaaaaaigadbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hccabaaaaeaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 17 [_Time]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 20 [unity_Scale]
Matrix 13 [_LightMatrix0]
Vector 21 [_Color]
Vector 22 [_MainTex_ST]
"!!ARBvp1.0
# 50 ALU
PARAM c[30] = { { 2, 1, 6.4088488, 3.1415927 },
		state.matrix.mvp,
		program.local[5..22],
		{ 1.2, 2, 1.6, 4.8000002 },
		{ 0.048, 0.059999999, 0.23999999, 0.096000001 },
		{ 0.024, 0.079999998, 0.2, -0.00019840999 },
		{ 0.0083333002, -0.16161616, 0 },
		{ 0.21538745, 0.35897908, 0.28718325, 0.86154979 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[0];
MAD R1.x, R0, -c[21].z, -vertex.color.z;
MUL R2.xyz, vertex.position.z, c[25];
ADD R1.x, R1, c[0].y;
MAD R0, vertex.position.x, c[24], R2.xyyz;
ADD R1.y, vertex.color, c[21];
MUL R1.x, R1, c[17];
MUL R1.x, R1, R1.y;
MAD R0, R1.x, c[23], R0;
FRC R0, R0;
MAD R0, R0, c[0].z, -c[0].w;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[26].y, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[26].x, R0;
MAD R0, R1, c[25].w, R0;
ADD R3.x, vertex.color.w, c[21].w;
MUL R2.x, vertex.texcoord[0].y, R3;
MUL R0, R0, R2.x;
MUL R0, R0, c[27];
MUL R0, R0, R0;
MUL R0, R0, R0;
DP4 R1.z, R0, c[28];
DP4 R1.x, R0, c[29];
MOV R1.y, c[26].z;
DP3 R0.y, R1, c[11];
DP3 R0.x, R1, c[9];
ADD R1.xz, vertex.position, -R0.xyyw;
MOV R1.yw, vertex.position;
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
DP4 R0.w, R1, c[8];
DP4 result.texcoord[4].w, R0, c[16];
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
ADD result.texcoord[2].xyz, -R0, c[19];
ADD result.texcoord[3].xyz, -R0, c[18];
MUL R0.xyz, vertex.normal, c[20].w;
DP4 result.position.w, R1, c[4];
DP4 result.position.z, R1, c[3];
DP4 result.position.y, R1, c[2];
DP4 result.position.x, R1, c[1];
DP3 result.texcoord[1].z, R0, c[7];
DP3 result.texcoord[1].y, R0, c[6];
DP3 result.texcoord[1].x, R0, c[5];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
END
# 50 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_Time]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 19 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 20 [_Color]
Vector 21 [_MainTex_ST]
"vs_2_0
; 52 ALU
def c22, 2.00000000, 1.00000000, 6.40884876, -3.14159274
def c23, 0.02400000, 0.08000000, 0.20000000, -0.16161616
def c24, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c25, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c26, 0.00833330, -0.00019841, 0.00000000, 0
def c27, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c28, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c29, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.x, c20.z
mad r1.x, c22, -r0, -v5.z
mul r2.xyz, v0.z, c23
add r1.x, r1, c22.y
mad r0, v0.x, c24, r2.xyyz
add r1.y, v5, c20
mul r1.x, r1, c16
mul r1.x, r1, r1.y
mad r0, r1.x, c25, r0
frc r0, r0
mad r0, r0, c22.z, c22.w
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c23.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c26.x, r0
mad r0, r1, c26.y, r0
add r3.x, v5.w, c20.w
mul r2.x, v3.y, r3
mul r0, r0, r2.x
mul r0, r0, c27
mul r0, r0, r0
mul r0, r0, r0
dp4 r1.z, r0, c28
dp4 r1.x, r0, c29
mov r1.y, c26.z
dp3 r0.y, r1, c10
dp3 r0.x, r1, c8
add r1.xz, v0, -r0.xyyw
mov r1.yw, v0
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp4 r0.w, r1, c7
dp4 oT4.w, r0, c15
dp4 oT4.z, r0, c14
dp4 oT4.y, r0, c13
dp4 oT4.x, r0, c12
add oT2.xyz, -r0, c18
add oT3.xyz, -r0, c17
mul r0.xyz, v2, c19.w
dp4 oPos.w, r1, c3
dp4 oPos.z, r1, c2
dp4 oPos.y, r1, c1
dp4 oPos.x, r1, c0
dp3 oT1.z, r0, c6
dp3 oT1.y, r0, c5
dp3 oT1.x, r0, c4
mad oT0.xy, v3, c21, c21.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 176 // 160 used size, 9 vars
Matrix 48 [_LightMatrix0] 4
Vector 128 [_Color] 4
Vector 144 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 0 [_Time] 4
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 51 instructions, 4 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkfgdieebpjmpfnhdjndfahamfbdjkmfoabaaaaaaliajaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcaeaiaaaaeaaaabaaabacaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadocbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacaeaaaaaa
diaaaaakpcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedmaknhkddn
aknhkddnmnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaaaceaaaaa
kgjleednipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaalbcaabaaa
abaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeaabeaaaaa
aaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaa
afaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaabaaaaaa
aaaaaaaaaaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaaaaaaaaaa
aiaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaadcaaaaam
pcaabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdp
jkjjjjeaegaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmneaekbfmnea
ekbfmneaekbfmneaaceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaah
pcaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
adaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaadaaaaaaaceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaa
aaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaa
diaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidm
gfiiaidmegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaa
aceaaaaaehamfaljehamfaljehamfaljehamfaljegaobaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddoihiofmdp
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaakbcaabaaa
abaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdn
bbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedmaknhcddn
ipmcpflnkgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaaagiccaaa
adaaaaaabcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaabaaaaaaa
agaabaaaaaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaia
ebaaaaaaaaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaaabaaaaaa
egbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaa
fgafbaaaabaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaa
egiicaaaadaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaak
hccabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaj
hccabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaa
aaaaaaajhccabaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaabaaaaaa
aeaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaafaaaaaaegiocaaaaaaaaaaa
agaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 176 // 160 used size, 9 vars
Matrix 48 [_LightMatrix0] 4
Vector 128 [_Color] 4
Vector 144 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 0 [_Time] 4
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 51 instructions, 4 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_3
eefiecedkopiggncgihocnfhbaobihciblfloicdabaaaaaapeaoaaaaaeaaaaaa
daaaaaaagiafaaaaheanaaaadmaoaaaaebgpgodjdaafaaaadaafaaaaaaacpopp
jmaeaaaajeaaaaaaajaaceaaaaaajaaaaaaajaaaaaaaceaaabaajaaaaaaaadaa
aeaaabaaaaaaaaaaaaaaaiaaacaaafaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaa
abaaaeaaabaaaiaaaaaaaaaaacaaaaaaabaaajaaaaaaaaaaadaaaaaaaeaaakaa
aaaaaaaaadaaamaaafaaaoaaaaaaaaaaadaabcaaabaabdaaaaaaaaaaadaabeaa
abaabeaaaaaaaaaaaaaaaaaaabacpoppfbaaaaafbfaaapkakgjleednipmchfdn
ipmchfdokgjlmednfbaaaaafbgaaapkakgjlmedmaknhkddnmnmmemdolfhocflo
fbaaaaafbhaaapkaaaaaaaeaaaaaiadpekbfmneanlapejmafbaaaaafbiaaapka
jkjjjjdpaaaaaaeamnmmmmdpjkjjjjeafbaaaaafbjaaapkagfiiaidmehamfalj
aaaaaaaaaaaaaaaafbaaaaafbkaaapkaihiofmdoblmmlhdokpajjddoihiofmdp
fbaaaaafblaaapkakgjlmedmaknhcddnipmcpflnkgjlmednfbaaaaafbmaaapka
kgjlmedlaknhkddmaknhkdlmmnmmmmdnbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaafiaafaaapja
aeaaaaaeaaaaadoaadaaoejaagaaoekaagaaookaafaaaaadaaaaahiaacaaoeja
beaappkaafaaaaadabaaahiaaaaaffiaapaaoekaaeaaaaaeaaaaaliaaoaakeka
aaaaaaiaabaakeiaaeaaaaaeabaaahoabaaaoekaaaaakkiaaaaapeiaafaaaaad
aaaaapiaaaaakkjabgaajekaaeaaaaaeaaaaapiaaaaaaajabfaaoekaaaaaoeia
abaaaaacabaaadiabhaaoekaaeaaaaaeabaaabiaafaakkkaabaaaaibabaaffia
acaaaaadabaaabiaabaaaaiaafaakkjbafaaaaadabaaabiaabaaaaiaahaaaaka
acaaaaadabaaagiaafaapejaafaapekaafaaaaadabaaabiaabaaffiaabaaaaia
afaaaaadabaaaciaabaakkiaadaaffjaaeaaaaaeaaaaapiaabaaaaiabiaaoeka
aaaaoeiabdaaaaacaaaaapiaaaaaoeiaaeaaaaaeaaaaapiaaaaaoeiabhaakkka
bhaappkaafaaaaadacaaapiaaaaaoeiaaaaaoeiaafaaaaadadaaapiaaaaaoeia
acaaoeiaaeaaaaaeaaaaapiaadaaoeiabgaappkaaaaaoeiaafaaaaadadaaapia
acaaoeiaadaaoeiaafaaaaadacaaapiaacaaoeiaadaaoeiaaeaaaaaeaaaaapia
adaaoeiabjaaaakaaaaaoeiaaeaaaaaeaaaaapiaacaaoeiabjaaffkaaaaaoeia
afaaaaadaaaaapiaabaaffiaaaaaoeiaafaaaaadaaaaapiaaaaaoeiabkaaoeka
afaaaaadaaaaapiaaaaaoeiaaaaaoeiaafaaaaadaaaaapiaaaaaoeiaaaaaoeia
ajaaaaadabaaabiaaaaaoeiabmaaoekaajaaaaadaaaaabiaaaaaoeiablaaoeka
afaaaaadaaaaagiaabaaaaiabdaaoakaaeaaaaaeaaaaadiabcaaoikaaaaaaaia
aaaaojiaacaaaaadaaaaadiaaaaaoeibaaaaoijaafaaaaadabaaahiaaaaaffja
apaaoekaaeaaaaaeabaaahiaaoaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaahia
baaaoekaaaaaffiaabaaoeiaaeaaaaaeabaaahiabbaaoekaaaaappjaabaaoeia
acaaaaadacaaahoaabaaoeibajaaoekaacaaaaadadaaahoaabaaoeibaiaaoeka
afaaaaadabaaapiaaaaaffjaapaaoekaaeaaaaaeabaaapiaaoaaoekaaaaaaaia
abaaoeiaaeaaaaaeabaaapiabaaaoekaaaaaffiaabaaoeiaaeaaaaaeabaaapia
bbaaoekaaaaappjaabaaoeiaafaaaaadacaaapiaabaaffiaacaaoekaaeaaaaae
acaaapiaabaaoekaabaaaaiaacaaoeiaaeaaaaaeacaaapiaadaaoekaabaakkia
acaaoeiaaeaaaaaeaeaaapoaaeaaoekaabaappiaacaaoeiaafaaaaadabaaapia
aaaaffjaalaaoekaaeaaaaaeabaaapiaakaaoekaaaaaaaiaabaaoeiaaeaaaaae
aaaaapiaamaaoekaaaaaffiaabaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiappppaaaafdeieefcaeaiaaaaeaaaabaaabacaaaafjaaaaaeegiocaaa
aaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
ocbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaak
pcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedmaknhkddnaknhkddn
mnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaaaceaaaaakgjleedn
ipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaiadp
aaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaafaaaaaa
diaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaa
aaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaaaaaaaaaaaiaaaaaa
diaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaadcaaaaampcaabaaa
aaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdpjkjjjjea
egaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaap
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmneaekbfmneaekbfmnea
ekbfmneaaceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaahpcaabaaa
acaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaa
egaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
adaaaaaaaceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaaaaaaaaaa
diaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadiaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidmgfiiaidm
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaa
ehamfaljehamfaljehamfaljehamfaljegaobaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddoihiofmdpdiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaa
egaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdnbbaaaaak
bcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedmaknhcddnipmcpfln
kgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaaagiccaaaadaaaaaa
bcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaabaaaaaaaagaabaaa
aaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaa
aaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
ajaaaaaaogikcaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaa
abaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaa
adaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhccabaaa
acaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
fgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhccabaaa
adaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaaaaaaaaaj
hccabaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaabaaaaaaaeaaaaaa
diaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaa
fgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpccabaaaafaaaaaaegiocaaaaaaaaaaaagaaaaaa
pgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 17 [_Time]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 20 [unity_Scale]
Matrix 13 [_LightMatrix0]
Vector 21 [_Color]
Vector 22 [_MainTex_ST]
"!!ARBvp1.0
# 49 ALU
PARAM c[30] = { { 2, 1, 6.4088488, 3.1415927 },
		state.matrix.mvp,
		program.local[5..22],
		{ 1.2, 2, 1.6, 4.8000002 },
		{ 0.048, 0.059999999, 0.23999999, 0.096000001 },
		{ 0.024, 0.079999998, 0.2, -0.00019840999 },
		{ 0.0083333002, -0.16161616, 0 },
		{ 0.21538745, 0.35897908, 0.28718325, 0.86154979 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[0];
MAD R1.x, R0, -c[21].z, -vertex.color.z;
MUL R2.xyz, vertex.position.z, c[25];
ADD R1.x, R1, c[0].y;
MAD R0, vertex.position.x, c[24], R2.xyyz;
ADD R1.y, vertex.color, c[21];
MUL R1.x, R1, c[17];
MUL R1.x, R1, R1.y;
MAD R0, R1.x, c[23], R0;
FRC R0, R0;
MAD R0, R0, c[0].z, -c[0].w;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[26].y, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[26].x, R0;
MAD R0, R1, c[25].w, R0;
ADD R3.x, vertex.color.w, c[21].w;
MUL R2.x, vertex.texcoord[0].y, R3;
MUL R0, R0, R2.x;
MUL R0, R0, c[27];
MUL R0, R0, R0;
MUL R0, R0, R0;
DP4 R1.z, R0, c[28];
DP4 R1.x, R0, c[29];
MOV R1.y, c[26].z;
DP3 R0.y, R1, c[11];
DP3 R0.x, R1, c[9];
ADD R1.xz, vertex.position, -R0.xyyw;
MOV R1.yw, vertex.position;
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
DP4 R0.w, R1, c[8];
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
ADD result.texcoord[2].xyz, -R0, c[19];
ADD result.texcoord[3].xyz, -R0, c[18];
MUL R0.xyz, vertex.normal, c[20].w;
DP4 result.position.w, R1, c[4];
DP4 result.position.z, R1, c[3];
DP4 result.position.y, R1, c[2];
DP4 result.position.x, R1, c[1];
DP3 result.texcoord[1].z, R0, c[7];
DP3 result.texcoord[1].y, R0, c[6];
DP3 result.texcoord[1].x, R0, c[5];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
END
# 49 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_Time]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 19 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 20 [_Color]
Vector 21 [_MainTex_ST]
"vs_2_0
; 51 ALU
def c22, 2.00000000, 1.00000000, 6.40884876, -3.14159274
def c23, 0.02400000, 0.08000000, 0.20000000, -0.16161616
def c24, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c25, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c26, 0.00833330, -0.00019841, 0.00000000, 0
def c27, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c28, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c29, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.x, c20.z
mad r1.x, c22, -r0, -v5.z
mul r2.xyz, v0.z, c23
add r1.x, r1, c22.y
mad r0, v0.x, c24, r2.xyyz
add r1.y, v5, c20
mul r1.x, r1, c16
mul r1.x, r1, r1.y
mad r0, r1.x, c25, r0
frc r0, r0
mad r0, r0, c22.z, c22.w
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c23.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c26.x, r0
mad r0, r1, c26.y, r0
add r3.x, v5.w, c20.w
mul r2.x, v3.y, r3
mul r0, r0, r2.x
mul r0, r0, c27
mul r0, r0, r0
mul r0, r0, r0
dp4 r1.z, r0, c28
dp4 r1.x, r0, c29
mov r1.y, c26.z
dp3 r0.y, r1, c10
dp3 r0.x, r1, c8
add r1.xz, v0, -r0.xyyw
mov r1.yw, v0
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp4 r0.w, r1, c7
dp4 oT4.z, r0, c14
dp4 oT4.y, r0, c13
dp4 oT4.x, r0, c12
add oT2.xyz, -r0, c18
add oT3.xyz, -r0, c17
mul r0.xyz, v2, c19.w
dp4 oPos.w, r1, c3
dp4 oPos.z, r1, c2
dp4 oPos.y, r1, c1
dp4 oPos.x, r1, c0
dp3 oT1.z, r0, c6
dp3 oT1.y, r0, c5
dp3 oT1.x, r0, c4
mad oT0.xy, v3, c21, c21.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 176 // 160 used size, 9 vars
Matrix 48 [_LightMatrix0] 4
Vector 128 [_Color] 4
Vector 144 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 0 [_Time] 4
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 51 instructions, 4 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedomjginpkphkebjnjncncgoeoblchlkfkabaaaaaaliajaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcaeaiaaaaeaaaabaaabacaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadocbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaa
diaaaaakpcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedmaknhkddn
aknhkddnmnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaaaceaaaaa
kgjleednipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaalbcaabaaa
abaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeaabeaaaaa
aaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaa
afaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaabaaaaaa
aaaaaaaaaaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaaaaaaaaaa
aiaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaadcaaaaam
pcaabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdp
jkjjjjeaegaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmneaekbfmnea
ekbfmneaekbfmneaaceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaah
pcaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
adaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaadaaaaaaaceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaa
aaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaa
diaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidm
gfiiaidmegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaa
aceaaaaaehamfaljehamfaljehamfaljehamfaljegaobaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddoihiofmdp
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaakbcaabaaa
abaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdn
bbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedmaknhcddn
ipmcpflnkgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaaagiccaaa
adaaaaaabcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaabaaaaaaa
agaabaaaaaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaia
ebaaaaaaaaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaaabaaaaaa
egbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaa
fgafbaaaabaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaa
egiicaaaadaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaak
hccabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaj
hccabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaa
aaaaaaajhccabaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaabaaaaaa
aeaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaaaaaaaaa
agaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 176 // 160 used size, 9 vars
Matrix 48 [_LightMatrix0] 4
Vector 128 [_Color] 4
Vector 144 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 0 [_Time] 4
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 51 instructions, 4 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_3
eefiecedaflefoekohpboiickhlfflecgljnhcfeabaaaaaapeaoaaaaaeaaaaaa
daaaaaaagiafaaaaheanaaaadmaoaaaaebgpgodjdaafaaaadaafaaaaaaacpopp
jmaeaaaajeaaaaaaajaaceaaaaaajaaaaaaajaaaaaaaceaaabaajaaaaaaaadaa
aeaaabaaaaaaaaaaaaaaaiaaacaaafaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaa
abaaaeaaabaaaiaaaaaaaaaaacaaaaaaabaaajaaaaaaaaaaadaaaaaaaeaaakaa
aaaaaaaaadaaamaaafaaaoaaaaaaaaaaadaabcaaabaabdaaaaaaaaaaadaabeaa
abaabeaaaaaaaaaaaaaaaaaaabacpoppfbaaaaafbfaaapkakgjleednipmchfdn
ipmchfdokgjlmednfbaaaaafbgaaapkakgjlmedmaknhkddnmnmmemdolfhocflo
fbaaaaafbhaaapkaaaaaaaeaaaaaiadpekbfmneanlapejmafbaaaaafbiaaapka
jkjjjjdpaaaaaaeamnmmmmdpjkjjjjeafbaaaaafbjaaapkagfiiaidmehamfalj
aaaaaaaaaaaaaaaafbaaaaafbkaaapkaihiofmdoblmmlhdokpajjddoihiofmdp
fbaaaaafblaaapkakgjlmedmaknhcddnipmcpflnkgjlmednfbaaaaafbmaaapka
kgjlmedlaknhkddmaknhkdlmmnmmmmdnbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaafiaafaaapja
aeaaaaaeaaaaadoaadaaoejaagaaoekaagaaookaafaaaaadaaaaahiaacaaoeja
beaappkaafaaaaadabaaahiaaaaaffiaapaaoekaaeaaaaaeaaaaaliaaoaakeka
aaaaaaiaabaakeiaaeaaaaaeabaaahoabaaaoekaaaaakkiaaaaapeiaafaaaaad
aaaaapiaaaaakkjabgaajekaaeaaaaaeaaaaapiaaaaaaajabfaaoekaaaaaoeia
abaaaaacabaaadiabhaaoekaaeaaaaaeabaaabiaafaakkkaabaaaaibabaaffia
acaaaaadabaaabiaabaaaaiaafaakkjbafaaaaadabaaabiaabaaaaiaahaaaaka
acaaaaadabaaagiaafaapejaafaapekaafaaaaadabaaabiaabaaffiaabaaaaia
afaaaaadabaaaciaabaakkiaadaaffjaaeaaaaaeaaaaapiaabaaaaiabiaaoeka
aaaaoeiabdaaaaacaaaaapiaaaaaoeiaaeaaaaaeaaaaapiaaaaaoeiabhaakkka
bhaappkaafaaaaadacaaapiaaaaaoeiaaaaaoeiaafaaaaadadaaapiaaaaaoeia
acaaoeiaaeaaaaaeaaaaapiaadaaoeiabgaappkaaaaaoeiaafaaaaadadaaapia
acaaoeiaadaaoeiaafaaaaadacaaapiaacaaoeiaadaaoeiaaeaaaaaeaaaaapia
adaaoeiabjaaaakaaaaaoeiaaeaaaaaeaaaaapiaacaaoeiabjaaffkaaaaaoeia
afaaaaadaaaaapiaabaaffiaaaaaoeiaafaaaaadaaaaapiaaaaaoeiabkaaoeka
afaaaaadaaaaapiaaaaaoeiaaaaaoeiaafaaaaadaaaaapiaaaaaoeiaaaaaoeia
ajaaaaadabaaabiaaaaaoeiabmaaoekaajaaaaadaaaaabiaaaaaoeiablaaoeka
afaaaaadaaaaagiaabaaaaiabdaaoakaaeaaaaaeaaaaadiabcaaoikaaaaaaaia
aaaaojiaacaaaaadaaaaadiaaaaaoeibaaaaoijaafaaaaadabaaahiaaaaaffja
apaaoekaaeaaaaaeabaaahiaaoaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaahia
baaaoekaaaaaffiaabaaoeiaaeaaaaaeabaaahiabbaaoekaaaaappjaabaaoeia
acaaaaadacaaahoaabaaoeibajaaoekaacaaaaadadaaahoaabaaoeibaiaaoeka
afaaaaadabaaapiaaaaaffjaapaaoekaaeaaaaaeabaaapiaaoaaoekaaaaaaaia
abaaoeiaaeaaaaaeabaaapiabaaaoekaaaaaffiaabaaoeiaaeaaaaaeabaaapia
bbaaoekaaaaappjaabaaoeiaafaaaaadacaaahiaabaaffiaacaaoekaaeaaaaae
acaaahiaabaaoekaabaaaaiaacaaoeiaaeaaaaaeabaaahiaadaaoekaabaakkia
acaaoeiaaeaaaaaeaeaaahoaaeaaoekaabaappiaabaaoeiaafaaaaadabaaapia
aaaaffjaalaaoekaaeaaaaaeabaaapiaakaaoekaaaaaaaiaabaaoeiaaeaaaaae
aaaaapiaamaaoekaaaaaffiaabaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiappppaaaafdeieefcaeaiaaaaeaaaabaaabacaaaafjaaaaaeegiocaaa
aaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
ocbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaak
pcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedmaknhkddnaknhkddn
mnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaaaceaaaaakgjleedn
ipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaiadp
aaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaafaaaaaa
diaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaa
aaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaaaaaaaaaaaiaaaaaa
diaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaadcaaaaampcaabaaa
aaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdpjkjjjjea
egaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaap
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmneaekbfmneaekbfmnea
ekbfmneaaceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaahpcaabaaa
acaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaa
egaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
adaaaaaaaceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaaaaaaaaaa
diaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadiaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidmgfiiaidm
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaa
ehamfaljehamfaljehamfaljehamfaljegaobaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddoihiofmdpdiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaa
egaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdnbbaaaaak
bcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedmaknhcddnipmcpfln
kgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaaagiccaaaadaaaaaa
bcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaabaaaaaaaagaabaaa
aaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaa
aaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
ajaaaaaaogikcaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaa
abaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaa
adaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhccabaaa
acaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
fgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhccabaaa
adaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaacaaaaaaaaaaaaaaaaaaaaaj
hccabaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaabaaaaaaaeaaaaaa
diaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaa
fgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaaaaaaaaaagaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 17 [_Time]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 20 [unity_Scale]
Matrix 13 [_LightMatrix0]
Vector 21 [_Color]
Vector 22 [_MainTex_ST]
"!!ARBvp1.0
# 48 ALU
PARAM c[30] = { { 2, 1, 6.4088488, 3.1415927 },
		state.matrix.mvp,
		program.local[5..22],
		{ 1.2, 2, 1.6, 4.8000002 },
		{ 0.048, 0.059999999, 0.23999999, 0.096000001 },
		{ 0.024, 0.079999998, 0.2, -0.00019840999 },
		{ 0.0083333002, -0.16161616, 0 },
		{ 0.21538745, 0.35897908, 0.28718325, 0.86154979 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[0];
MAD R1.x, R0, -c[21].z, -vertex.color.z;
MUL R2.xyz, vertex.position.z, c[25];
ADD R1.x, R1, c[0].y;
MAD R0, vertex.position.x, c[24], R2.xyyz;
ADD R1.y, vertex.color, c[21];
MUL R1.x, R1, c[17];
MUL R1.x, R1, R1.y;
MAD R0, R1.x, c[23], R0;
FRC R0, R0;
MAD R0, R0, c[0].z, -c[0].w;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[26].y, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[26].x, R0;
MAD R0, R1, c[25].w, R0;
ADD R3.x, vertex.color.w, c[21].w;
MUL R2.x, vertex.texcoord[0].y, R3;
MUL R0, R0, R2.x;
MUL R0, R0, c[27];
MUL R0, R0, R0;
MUL R0, R0, R0;
DP4 R1.z, R0, c[28];
DP4 R1.x, R0, c[29];
MOV R1.y, c[26].z;
DP3 R0.y, R1, c[11];
DP3 R0.x, R1, c[9];
ADD R1.xz, vertex.position, -R0.xyyw;
MOV R1.yw, vertex.position;
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
DP4 R0.w, R1, c[8];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
ADD result.texcoord[3].xyz, -R0, c[18];
MUL R0.xyz, vertex.normal, c[20].w;
DP4 result.position.w, R1, c[4];
DP4 result.position.z, R1, c[3];
DP4 result.position.y, R1, c[2];
DP4 result.position.x, R1, c[1];
DP3 result.texcoord[1].z, R0, c[7];
DP3 result.texcoord[1].y, R0, c[6];
DP3 result.texcoord[1].x, R0, c[5];
MOV result.texcoord[2].xyz, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
END
# 48 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_Time]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 19 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 20 [_Color]
Vector 21 [_MainTex_ST]
"vs_2_0
; 50 ALU
def c22, 2.00000000, 1.00000000, 6.40884876, -3.14159274
def c23, 0.02400000, 0.08000000, 0.20000000, -0.16161616
def c24, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c25, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c26, 0.00833330, -0.00019841, 0.00000000, 0
def c27, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c28, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c29, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.x, c20.z
mad r1.x, c22, -r0, -v5.z
mul r2.xyz, v0.z, c23
add r1.x, r1, c22.y
mad r0, v0.x, c24, r2.xyyz
add r1.y, v5, c20
mul r1.x, r1, c16
mul r1.x, r1, r1.y
mad r0, r1.x, c25, r0
frc r0, r0
mad r0, r0, c22.z, c22.w
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c23.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c26.x, r0
mad r0, r1, c26.y, r0
add r3.x, v5.w, c20.w
mul r2.x, v3.y, r3
mul r0, r0, r2.x
mul r0, r0, c27
mul r0, r0, r0
mul r0, r0, r0
dp4 r1.z, r0, c28
dp4 r1.x, r0, c29
mov r1.y, c26.z
dp3 r0.y, r1, c10
dp3 r0.x, r1, c8
add r1.xz, v0, -r0.xyyw
mov r1.yw, v0
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp4 r0.w, r1, c7
dp4 oT4.y, r0, c13
dp4 oT4.x, r0, c12
add oT3.xyz, -r0, c17
mul r0.xyz, v2, c19.w
dp4 oPos.w, r1, c3
dp4 oPos.z, r1, c2
dp4 oPos.y, r1, c1
dp4 oPos.x, r1, c0
dp3 oT1.z, r0, c6
dp3 oT1.y, r0, c5
dp3 oT1.x, r0, c4
mov oT2.xyz, c18
mad oT0.xy, v3, c21, c21.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 176 // 160 used size, 9 vars
Matrix 48 [_LightMatrix0] 4
Vector 128 [_Color] 4
Vector 144 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 0 [_Time] 4
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 51 instructions, 4 temp regs, 0 temp arrays:
// ALU 26 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedjijjekckbnehfbclellnlnlcplkkanjmabaaaaaakmajaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcpiahaaaaeaaaabaapoabaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaadocbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacaeaaaaaa
diaaaaakpcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedmaknhkddn
aknhkddnmnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaaaceaaaaa
kgjleednipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaalbcaabaaa
abaaaaaackiacaiaebaaaaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeaabeaaaaa
aaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaa
afaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaabaaaaaa
aaaaaaaaaaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaaaaaaaaaa
aiaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaadcaaaaam
pcaabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdp
jkjjjjeaegaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmneaekbfmnea
ekbfmneaekbfmneaaceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaah
pcaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
adaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaadaaaaaaaceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaa
aaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaa
diaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidm
gfiiaidmegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaa
aceaaaaaehamfaljehamfaljehamfaljehamfaljegaobaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddoihiofmdp
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaakbcaabaaa
abaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdn
bbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedmaknhcddn
ipmcpflnkgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaaagiccaaa
adaaaaaabcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaabaaaaaaa
agaabaaaaaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaia
ebaaaaaaaaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaaoaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaaimcaabaaaaaaaaaaafgafbaaaabaaaaaaagiecaaaaaaaaaaaaeaaaaaa
dcaaaaakmcaabaaaaaaaaaaaagiecaaaaaaaaaaaadaaaaaaagaabaaaabaaaaaa
kgaobaaaaaaaaaaadcaaaaakmcaabaaaaaaaaaaaagiecaaaaaaaaaaaafaaaaaa
kgakbaaaabaaaaaakgaobaaaaaaaaaaadcaaaaakmccabaaaabaaaaaaagiecaaa
aaaaaaaaagaaaaaapgapbaaaabaaaaaakgaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaa
ajaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
abaaaaaaegaibaaaacaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaaghccabaaaadaaaaaa
egiccaaaacaaaaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakncaabaaaaaaaaaaaagijcaaaadaaaaaa
amaaaaaaagaabaaaaaaaaaaaagajbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaafgafbaaaaaaaaaaaigadbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhccabaaaaeaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 176 // 160 used size, 9 vars
Matrix 48 [_LightMatrix0] 4
Vector 128 [_Color] 4
Vector 144 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 0 [_Time] 4
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 51 instructions, 4 temp regs, 0 temp arrays:
// ALU 26 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_3
eefiecednodfencllgoefolpdgcdodndepfkghnbabaaaaaaoeaoaaaaaeaaaaaa
daaaaaaageafaaaageanaaaacmaoaaaaebgpgodjcmafaaaacmafaaaaaaacpopp
jiaeaaaajeaaaaaaajaaceaaaaaajaaaaaaajaaaaaaaceaaabaajaaaaaaaadaa
aeaaabaaaaaaaaaaaaaaaiaaacaaafaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaa
abaaaeaaabaaaiaaaaaaaaaaacaaaaaaabaaajaaaaaaaaaaadaaaaaaaeaaakaa
aaaaaaaaadaaamaaafaaaoaaaaaaaaaaadaabcaaabaabdaaaaaaaaaaadaabeaa
abaabeaaaaaaaaaaaaaaaaaaabacpoppfbaaaaafbfaaapkakgjleednipmchfdn
ipmchfdokgjlmednfbaaaaafbgaaapkakgjlmedmaknhkddnmnmmemdolfhocflo
fbaaaaafbhaaapkaaaaaaaeaaaaaiadpekbfmneanlapejmafbaaaaafbiaaapka
jkjjjjdpaaaaaaeamnmmmmdpjkjjjjeafbaaaaafbjaaapkagfiiaidmehamfalj
aaaaaaaaaaaaaaaafbaaaaafbkaaapkaihiofmdoblmmlhdokpajjddoihiofmdp
fbaaaaafblaaapkakgjlmedmaknhcddnipmcpflnkgjlmednfbaaaaafbmaaapka
kgjlmedlaknhkddmaknhkdlmmnmmmmdnbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaafiaafaaapja
aeaaaaaeaaaaadoaadaaoejaagaaoekaagaaookaafaaaaadaaaaahiaacaaoeja
beaappkaafaaaaadabaaahiaaaaaffiaapaaoekaaeaaaaaeaaaaaliaaoaakeka
aaaaaaiaabaakeiaaeaaaaaeabaaahoabaaaoekaaaaakkiaaaaapeiaafaaaaad
aaaaapiaaaaakkjabgaajekaaeaaaaaeaaaaapiaaaaaaajabfaaoekaaaaaoeia
abaaaaacabaaadiabhaaoekaaeaaaaaeabaaabiaafaakkkaabaaaaibabaaffia
acaaaaadabaaabiaabaaaaiaafaakkjbafaaaaadabaaabiaabaaaaiaahaaaaka
acaaaaadabaaagiaafaapejaafaapekaafaaaaadabaaabiaabaaffiaabaaaaia
afaaaaadabaaaciaabaakkiaadaaffjaaeaaaaaeaaaaapiaabaaaaiabiaaoeka
aaaaoeiabdaaaaacaaaaapiaaaaaoeiaaeaaaaaeaaaaapiaaaaaoeiabhaakkka
bhaappkaafaaaaadacaaapiaaaaaoeiaaaaaoeiaafaaaaadadaaapiaaaaaoeia
acaaoeiaaeaaaaaeaaaaapiaadaaoeiabgaappkaaaaaoeiaafaaaaadadaaapia
acaaoeiaadaaoeiaafaaaaadacaaapiaacaaoeiaadaaoeiaaeaaaaaeaaaaapia
adaaoeiabjaaaakaaaaaoeiaaeaaaaaeaaaaapiaacaaoeiabjaaffkaaaaaoeia
afaaaaadaaaaapiaabaaffiaaaaaoeiaafaaaaadaaaaapiaaaaaoeiabkaaoeka
afaaaaadaaaaapiaaaaaoeiaaaaaoeiaafaaaaadaaaaapiaaaaaoeiaaaaaoeia
ajaaaaadabaaabiaaaaaoeiabmaaoekaajaaaaadaaaaabiaaaaaoeiablaaoeka
afaaaaadaaaaagiaabaaaaiabdaaoakaaeaaaaaeaaaaadiabcaaoikaaaaaaaia
aaaaojiaacaaaaadaaaaadiaaaaaoeibaaaaoijaafaaaaadabaaahiaaaaaffja
apaaoekaaeaaaaaeabaaahiaaoaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaahia
baaaoekaaaaaffiaabaaoeiaaeaaaaaeabaaahiabbaaoekaaaaappjaabaaoeia
acaaaaadadaaahoaabaaoeibaiaaoekaafaaaaadabaaapiaaaaaffjaapaaoeka
aeaaaaaeabaaapiaaoaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaapiabaaaoeka
aaaaffiaabaaoeiaaeaaaaaeabaaapiabbaaoekaaaaappjaabaaoeiaafaaaaad
aaaaamiaabaaffiaacaabekaaeaaaaaeaaaaamiaabaabekaabaaaaiaaaaaoeia
aeaaaaaeaaaaamiaadaabekaabaakkiaaaaaoeiaaeaaaaaeaaaaamoaaeaabeka
abaappiaaaaaoeiaafaaaaadabaaapiaaaaaffjaalaaoekaaeaaaaaeabaaapia
akaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaaffiaabaaoeia
aeaaaaaeaaaaapiaanaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaahoaajaaoeka
ppppaaaafdeieefcpiahaaaaeaaaabaapoabaaaafjaaaaaeegiocaaaaaaaaaaa
akaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadocbabaaa
afaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadmccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaakpcaabaaa
aaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedmaknhkddnaknhkddnmnmmemdo
dcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaaaceaaaaakgjleednipmchfdn
ipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaackiacaia
ebaaaaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaiadpaaaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaafaaaaaadiaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaaaaaaaaai
gcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaaaaaaaaaaaiaaaaaadiaaaaah
bcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaa
abaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaadcaaaaampcaabaaaaaaaaaaa
agaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdpjkjjjjeaegaobaaa
aaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaappcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmneaekbfmneaekbfmneaekbfmnea
aceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaahpcaabaaaacaaaaaa
egaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaa
aaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaa
aceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaaaaaaaaaadiaaaaah
pcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaa
acaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidmgfiiaidmegaobaaa
aaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaaehamfalj
ehamfaljehamfaljehamfaljegaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
fgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddoihiofmdpdiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaaegaobaaa
aaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdnbbaaaaakbcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedmaknhcddnipmcpflnkgjlmedn
diaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaaagiccaaaadaaaaaabcaaaaaa
dcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaabaaaaaaaagaabaaaaaaaaaaa
jgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaa
igbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaa
fgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaimcaabaaa
aaaaaaaafgafbaaaabaaaaaaagiecaaaaaaaaaaaaeaaaaaadcaaaaakmcaabaaa
aaaaaaaaagiecaaaaaaaaaaaadaaaaaaagaabaaaabaaaaaakgaobaaaaaaaaaaa
dcaaaaakmcaabaaaaaaaaaaaagiecaaaaaaaaaaaafaaaaaakgakbaaaabaaaaaa
kgaobaaaaaaaaaaadcaaaaakmccabaaaabaaaaaaagiecaaaaaaaaaaaagaaaaaa
pgapbaaaabaaaaaakgaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadiaaaaai
hcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaai
hcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
lcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaa
acaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaa
abaaaaaaegadbaaaabaaaaaadgaaaaaghccabaaaadaaaaaaegiccaaaacaaaaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakncaabaaaaaaaaaaaagijcaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaagajbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaafgafbaaaaaaaaaaaigadbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hccabaaaaeaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}

}
Program "fp" {
// Fragment combos: 5
//   opengl - ALU: 22 to 33, TEX: 1 to 3
//   d3d9 - ALU: 23 to 33, TEX: 2 to 4
//   d3d11 - ALU: 15 to 25, TEX: 1 to 3, FLOW: 1 to 1
//   d3d11_9x - ALU: 15 to 25, TEX: 1 to 3, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_VertexLitTranslucencyColor]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 27 ALU, 2 TEX
PARAM c[5] = { program.local[0..2],
		{ 4, 0, 0.85009766, 0.099975586 },
		{ 0.70019531, 0.30004883, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R1.y, R0.w, c[2].x;
DP3 R1.x, fragment.texcoord[4], fragment.texcoord[4];
DP3 R2.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R2.x, R2.x;
MUL R2.xyz, R2.x, fragment.texcoord[3];
MOV result.color.w, R0;
TEX R1.w, R1.x, texture[1], 2D;
KIL -R1.y;
DP3 R1.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R1.x, R1.x;
MUL R1.xyz, R1.x, fragment.texcoord[2];
DP3 R2.w, R1, fragment.texcoord[1];
DP3_SAT R1.x, R2, -R1;
MOV_SAT R3.x, -R2.w;
ADD R1.x, R1, -R3;
MAD R1.y, R1.x, c[3].z, R3.x;
ADD R1.x, R0.y, -c[3].w;
MAD R1.z, R2.w, c[4].x, c[4].y;
MAX R2.x, R1.z, c[3].y;
MUL R1.x, R1.y, R1;
MUL R1.xyz, R1.x, c[1];
MAD R1.xyz, R1, c[3].x, R2.x;
MUL R0.xyz, R0, c[0];
MUL R0.xyz, R0, R1;
MUL R0.xyz, R1.w, R0;
MUL result.color.xyz, R0, c[4].z;
END
# 27 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_VertexLitTranslucencyColor]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTexture0] 2D
"ps_2_0
; 28 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
def c3, 0.00000000, 1.00000000, 0.70019531, 0.30004883
def c4, -0.09997559, 0.85009766, 4.00000000, 2.00000000
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
texld r2, t0, s0
add_pp r0.x, r2.w, -c2
cmp r1.x, r0, c3, c3.y
mov_pp r1, -r1.x
dp3 r0.x, t4, t4
mov r0.xy, r0.x
mov_pp r0.w, r2
texld r5, r0, s1
texkill r1.xyzw
dp3_pp r0.x, t2, t2
rsq_pp r1.x, r0.x
mul_pp r3.xyz, r1.x, t2
dp3_pp r0.x, t3, t3
rsq_pp r1.x, r0.x
dp3_pp r0.x, r3, t1
mul_pp r4.xyz, r1.x, t3
mov_pp_sat r1.x, -r0
dp3_pp_sat r3.x, r4, -r3
add_pp r3.x, r3, -r1
mad_pp r3.x, r3, c4.y, r1
add_pp r1.x, r2.y, c4
mad_pp r0.x, r0, c3.z, c3.w
mul_pp r1.x, r3, r1
mul_pp r1.xyz, r1.x, c1
max_pp r0.x, r0, c3
mad_pp r0.xyz, r1, c4.z, r0.x
mul_pp r1.xyz, r2, c0
mul_pp r0.xyz, r1, r0
mul_pp r0.xyz, r5.x, r0
mul_pp r0.xyz, r0, c4.w
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "POINT" }
ConstBuffer "$Globals" 176 // 164 used size, 9 vars
Vector 16 [_LightColor0] 4
Vector 112 [_VertexLitTranslucencyColor] 3
Float 160 [_Cutoff]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
// 29 instructions, 3 temp regs, 0 temp arrays:
// ALU 20 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedhehmkkdhpnoaheghikgacjpgjhipefpcabaaaaaapeaeaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcneadaaaa
eaaaaaaapfaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaa
aaaaaaaaakaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
aeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaabaaaaaah
icaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaa
egbcbaaaadaaaaaabacaaaaibcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaia
ebaaaaaaacaaaaaabaaaaaahccaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaa
acaaaaaadgcaaaagecaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaaj
ccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaadddddddpabeaaaaajkjjjjdo
deaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaai
bcaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaaj
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaajkjjfjdpckaabaaaabaaaaaa
aaaaaaahecaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaamnmmmmlndiaaaaah
bcaabaaaabaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaincaabaaa
abaaaaaaagaabaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaadcaaaaamhcaabaaa
abaaaaaaigadbaaaabaaaaaaaceaaaaaaaaaiaeaaaaaiaeaaaaaiaeaaaaaaaaa
fgafbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaa
pgapbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { "POINT" }
ConstBuffer "$Globals" 176 // 164 used size, 9 vars
Vector 16 [_LightColor0] 4
Vector 112 [_VertexLitTranslucencyColor] 3
Float 160 [_Cutoff]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
// 29 instructions, 3 temp regs, 0 temp arrays:
// ALU 20 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_3
eefiecedbkdbdhnkimnjdkdbbdjjjcppnpmjihmcabaaaaaadmahaaaaaeaaaaaa
daaaaaaaheacaaaafaagaaaaaiahaaaaebgpgodjdmacaaaadmacaaaaaaacpppp
omabaaaafaaaaaaaadaacmaaaaaafaaaaaaafaaaacaaceaaaaaafaaaabaaaaaa
aaababaaaaaaabaaabaaaaaaaaaaaaaaaaaaahaaabaaabaaaaaaaaaaaaaaakaa
abaaacaaaaaaaaaaabacppppfbaaaaafadaaapkajkjjfjdpmnmmmmlndddddddp
jkjjjjdofbaaaaafaeaaapkaaaaaaaaaaaaaiaeaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaadlabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaachla
bpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaaahlabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaadaaaacpiaaaaaoelaabaioeka
acaaaaadabaacpiaaaaappiaacaaaakbaiaaaaadacaaaiiaaeaaoelaaeaaoela
abaaaaacacaaadiaacaappiaebaaaaababaaapiaecaaaaadabaacpiaacaaoeia
aaaioekaceaaaaacacaachiaadaaoelaceaaaaacadaachiaacaaoelaaiaaaaad
adaadiiaacaaoeiaadaaoeibaiaaaaadabaacciaabaaoelaadaaoeiaabaaaaac
abaadeiaabaaffibaeaaaaaeabaacciaabaaffiaadaakkkaadaappkaalaaaaad
acaacbiaabaaffiaaeaaaakabcaaaaaeacaacciaadaaaakaadaappiaabaakkia
acaaaaadabaacciaaaaaffiaadaaffkaafaaaaadabaacciaabaaffiaacaaffia
afaaaaadabaacoiaabaaffiaabaajakaaeaaaaaeabaacoiaabaaoeiaaeaaffka
acaaaaiaafaaaaadacaachiaaaaaoeiaaaaaoekaafaaaaadabaacoiaabaaoeia
acaajaiaacaaaaadabaacbiaabaaaaiaabaaaaiaafaaaaadaaaachiaabaaaaia
abaapjiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcneadaaaaeaaaaaaa
pfaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
aaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaa
akaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaa
egbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaabaaaaaahicaabaaa
abaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegbcbaaa
adaaaaaabacaaaaibcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaa
dgcaaaagecaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaajccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaadddddddpabeaaaaajkjjjjdodeaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaaibcaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaajkjjfjdpckaabaaaabaaaaaaaaaaaaah
ecaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaamnmmmmlndiaaaaahbcaabaaa
abaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaincaabaaaabaaaaaa
agaabaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaadcaaaaamhcaabaaaabaaaaaa
igadbaaaabaaaaaaaceaaaaaaaaaiaeaaaaaiaeaaaaaiaeaaaaaaaaafgafbaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaa
keaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_VertexLitTranslucencyColor]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 22 ALU, 1 TEX
PARAM c[5] = { program.local[0..2],
		{ 4, 0, 0.85009766, 0.099975586 },
		{ 0.70019531, 0.30004883, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R1.x, R0.w, c[2];
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R2.x, R1.w;
MOV result.color.w, R0;
KIL -R1.x;
MOV R1.xyz, fragment.texcoord[2];
DP3 R1.w, fragment.texcoord[1], R1;
MUL R1.xyz, R2.x, fragment.texcoord[3];
DP3_SAT R1.x, R1, -fragment.texcoord[2];
MOV_SAT R2.x, -R1.w;
MAD R1.z, R1.w, c[4].x, c[4].y;
ADD R1.x, R1, -R2;
MAD R1.y, R1.x, c[3].z, R2.x;
ADD R1.x, R0.y, -c[3].w;
MAX R1.w, R1.z, c[3].y;
MUL R1.x, R1.y, R1;
MUL R1.xyz, R1.x, c[1];
MAD R1.xyz, R1, c[3].x, R1.w;
MUL R0.xyz, R0, c[0];
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[4].z;
END
# 22 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_VertexLitTranslucencyColor]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 23 ALU, 2 TEX
dcl_2d s0
def c3, 0.00000000, 1.00000000, 0.70019531, 0.30004883
def c4, -0.09997559, 0.85009766, 4.00000000, 2.00000000
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r2, t0, s0
add_pp r0.x, r2.w, -c2
cmp r0.x, r0, c3, c3.y
mov_pp r0, -r0.x
mov_pp r3.xyz, t2
texkill r0.xyzw
dp3_pp r0.x, t3, t3
rsq_pp r1.x, r0.x
dp3_pp r0.x, t1, r3
mul_pp r3.xyz, r1.x, t3
mov_pp_sat r1.x, -r0
dp3_pp_sat r3.x, r3, -t2
add_pp r3.x, r3, -r1
mad_pp r3.x, r3, c4.y, r1
add_pp r1.x, r2.y, c4
mad_pp r0.x, r0, c3.z, c3.w
mul_pp r1.x, r3, r1
mul_pp r1.xyz, r1.x, c1
max_pp r0.x, r0, c3
mad_pp r0.xyz, r1, c4.z, r0.x
mul_pp r1.xyz, r2, c0
mul_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c4.w
mov_pp r0.w, r2
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
ConstBuffer "$Globals" 112 // 100 used size, 8 vars
Vector 16 [_LightColor0] 4
Vector 48 [_VertexLitTranslucencyColor] 3
Float 96 [_Cutoff]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
// 23 instructions, 2 temp regs, 0 temp arrays:
// ALU 15 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedhjdlabeigapkepfocnnemelfmnppbnjjabaaaaaaamaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcaeadaaaaeaaaaaaambaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaa
aaaaaaaaagaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
aeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaabacaaaai
bcaabaaaabaaaaaaegacbaaaabaaaaaaegbcbaiaebaaaaaaadaaaaaabaaaaaah
ccaabaaaabaaaaaaegbcbaaaacaaaaaaegbcbaaaadaaaaaadgcaaaagecaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaadddddddpabeaaaaajkjjjjdodeaaaaahccaabaaaabaaaaaa
bkaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaaibcaabaaaabaaaaaackaabaia
ebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaajkjjfjdpckaabaaaabaaaaaaaaaaaaahecaabaaaabaaaaaa
bkaabaaaaaaaaaaaabeaaaaamnmmmmlndiaaaaahbcaabaaaabaaaaaackaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaaincaabaaaabaaaaaaagaabaaaabaaaaaa
agijcaaaaaaaaaaaadaaaaaadcaaaaamhcaabaaaabaaaaaaigadbaaaabaaaaaa
aceaaaaaaaaaiaeaaaaaiaeaaaaaiaeaaaaaaaaafgafbaaaabaaaaaadiaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
ConstBuffer "$Globals" 112 // 100 used size, 8 vars
Vector 16 [_LightColor0] 4
Vector 48 [_VertexLitTranslucencyColor] 3
Float 96 [_Cutoff]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
// 23 instructions, 2 temp regs, 0 temp arrays:
// ALU 15 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_3
eefiecedknkjbacmmddfmgjboofmlhojbcdobdipabaaaaaapmafaaaaaeaaaaaa
daaaaaaabmacaaaaciafaaaamiafaaaaebgpgodjoeabaaaaoeabaaaaaaacpppp
jiabaaaaemaaaaaaadaaciaaaaaaemaaaaaaemaaabaaceaaaaaaemaaaaaaaaaa
aaaaabaaabaaaaaaaaaaaaaaaaaaadaaabaaabaaaaaaaaaaaaaaagaaabaaacaa
aaaaaaaaabacppppfbaaaaafadaaapkajkjjfjdpmnmmmmlndddddddpjkjjjjdo
fbaaaaafaeaaapkaaaaaaaaaaaaaiaeaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaahlabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaac
aaaaaaiaadaachlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaacpiaaaaaoela
aaaioekaacaaaaadabaacpiaaaaappiaacaaaakbebaaaaababaaapiaceaaaaac
abaachiaadaaoelaaiaaaaadabaadbiaabaaoeiaacaaoelbabaaaaacacaaahia
acaaoelaaiaaaaadabaacciaabaaoelaacaaoeiaabaaaaacabaadeiaabaaffib
aeaaaaaeabaacciaabaaffiaadaakkkaadaappkaalaaaaadacaacbiaabaaffia
aeaaaakabcaaaaaeacaacciaadaaaakaabaaaaiaabaakkiaacaaaaadabaacbia
aaaaffiaadaaffkaafaaaaadabaacbiaabaaaaiaacaaffiaafaaaaadabaachia
abaaaaiaabaaoekaaeaaaaaeabaachiaabaaoeiaaeaaffkaacaaaaiaafaaaaad
acaachiaaaaaoeiaaaaaoekaafaaaaadabaachiaabaaoeiaacaaoeiaacaaaaad
aaaachiaabaaoeiaabaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
aeadaaaaeaaaaaaambaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaa
agaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaa
egbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaabacaaaaibcaabaaa
abaaaaaaegacbaaaabaaaaaaegbcbaiaebaaaaaaadaaaaaabaaaaaahccaabaaa
abaaaaaaegbcbaaaacaaaaaaegbcbaaaadaaaaaadgcaaaagecaabaaaabaaaaaa
bkaabaiaebaaaaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaadddddddpabeaaaaajkjjjjdodeaaaaahccaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaaaaaaaaaaaaaaaaaibcaabaaaabaaaaaackaabaiaebaaaaaa
abaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaajkjjfjdpckaabaaaabaaaaaaaaaaaaahecaabaaaabaaaaaabkaabaaa
aaaaaaaaabeaaaaamnmmmmlndiaaaaahbcaabaaaabaaaaaackaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaaincaabaaaabaaaaaaagaabaaaabaaaaaaagijcaaa
aaaaaaaaadaaaaaadcaaaaamhcaabaaaabaaaaaaigadbaaaabaaaaaaaceaaaaa
aaaaiaeaaaaaiaeaaaaaiaeaaaaaaaaafgafbaaaabaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaaaaaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_VertexLitTranslucencyColor]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTexture0] 2D
SetTexture 2 [_LightTextureB0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 33 ALU, 3 TEX
PARAM c[5] = { program.local[0..2],
		{ 4, 0, 0.85009766, 0.099975586 },
		{ 0.70019531, 0.30004883, 2, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R2, fragment.texcoord[0], texture[0], 2D;
SLT R0.w, R2, c[2].x;
DP3 R0.z, fragment.texcoord[4], fragment.texcoord[4];
RCP R0.x, fragment.texcoord[4].w;
DP3 R1.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R1.x, R1.x;
MAD R0.xy, fragment.texcoord[4], R0.x, c[4].w;
MUL R1.xyz, R1.x, fragment.texcoord[3];
MOV result.color.w, R2;
KIL -R0.w;
TEX R0.w, R0, texture[1], 2D;
TEX R1.w, R0.z, texture[2], 2D;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[2];
DP3 R3.x, R0, fragment.texcoord[1];
DP3_SAT R0.x, R1, -R0;
MOV_SAT R3.y, -R3.x;
ADD R0.x, R0, -R3.y;
MAD R0.y, R0.x, c[3].z, R3;
MAD R0.z, R3.x, c[4].x, c[4].y;
ADD R0.x, R2.y, -c[3].w;
MAX R1.x, R0.z, c[3].y;
MUL R0.x, R0.y, R0;
MUL R0.xyz, R0.x, c[1];
MAD R0.xyz, R0, c[3].x, R1.x;
MUL R1.xyz, R2, c[0];
MUL R0.xyz, R1, R0;
SLT R1.x, c[3].y, fragment.texcoord[4].z;
MUL R0.w, R1.x, R0;
MUL R0.w, R0, R1;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[4].z;
END
# 33 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_VertexLitTranslucencyColor]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTexture0] 2D
SetTexture 2 [_LightTextureB0] 2D
"ps_2_0
; 33 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 0.00000000, 1.00000000, 0.50000000, -0.09997559
def c4, 0.70019531, 0.30004883, 0.85009766, 4.00000000
def c5, 2.00000000, 0, 0, 0
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4
texld r2, t0, s0
add_pp r0.x, r2.w, -c2
cmp r0.x, r0, c3, c3.y
mov_pp r3, -r0.x
dp3 r1.x, t4, t4
mov r1.xy, r1.x
rcp r0.x, t4.w
mad r0.xy, t4, r0.x, c3.z
texld r0, r0, s1
texld r5, r1, s2
texkill r3.xyzw
dp3_pp r0.x, t2, t2
rsq_pp r1.x, r0.x
mul_pp r3.xyz, r1.x, t2
dp3_pp r0.x, t3, t3
rsq_pp r1.x, r0.x
dp3_pp r0.x, r3, t1
mul_pp r4.xyz, r1.x, t3
mov_pp_sat r1.x, -r0
dp3_pp_sat r3.x, r4, -r3
add_pp r3.x, r3, -r1
mad_pp r3.x, r3, c4.z, r1
add_pp r1.x, r2.y, c3.w
mad_pp r0.x, r0, c4, c4.y
mul_pp r1.x, r3, r1
mul_pp r1.xyz, r1.x, c1
max_pp r0.x, r0, c3
mad_pp r0.xyz, r1, c4.w, r0.x
mul_pp r1.xyz, r2, c0
mul_pp r1.xyz, r1, r0
cmp r0.x, -t4.z, c3, c3.y
mul_pp r0.x, r0, r0.w
mul_pp r0.x, r0, r5
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c5.x
mov_pp r0.w, r2
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" }
ConstBuffer "$Globals" 176 // 164 used size, 9 vars
Vector 16 [_LightColor0] 4
Vector 112 [_VertexLitTranslucencyColor] 3
Float 160 [_Cutoff]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTexture0] 2D 0
SetTexture 2 [_LightTextureB0] 2D 1
// 35 instructions, 3 temp regs, 0 temp arrays:
// ALU 24 float, 0 int, 1 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedlnhnigdmgickpobefmmcgabdbggneabaabaaaaaammafaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmaeaaaa
eaaaaaaaclabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
pcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
aaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaa
akaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaa
egbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaabaaaaaahicaabaaa
abaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegbcbaaa
adaaaaaabacaaaaibcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaa
dgcaaaagecaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaajccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaadddddddpabeaaaaajkjjjjdodeaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaaibcaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaajkjjfjdpckaabaaaabaaaaaaaaaaaaah
ecaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaamnmmmmlndiaaaaahbcaabaaa
abaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaincaabaaaabaaaaaa
agaabaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaadcaaaaamhcaabaaaabaaaaaa
igadbaaaabaaaaaaaceaaaaaaaaaiaeaaaaaiaeaaaaaiaeaaaaaaaaafgafbaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaafaaaaaapgbpbaaaafaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaa
abaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaafaaaaaaabaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaa
aaaaaaaaagaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { "SPOT" }
ConstBuffer "$Globals" 176 // 164 used size, 9 vars
Vector 16 [_LightColor0] 4
Vector 112 [_VertexLitTranslucencyColor] 3
Float 160 [_Cutoff]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTexture0] 2D 0
SetTexture 2 [_LightTextureB0] 2D 1
// 35 instructions, 3 temp regs, 0 temp arrays:
// ALU 24 float, 0 int, 1 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_3
eefiecedoohpcipockibdlmjimlgdpibhdpdlmfpabaaaaaagmaiaaaaaeaaaaaa
daaaaaaammacaaaaiaahaaaadiaiaaaaebgpgodjjeacaaaajeacaaaaaaacpppp
eaacaaaafeaaaaaaadaadaaaaaaafeaaaaaafeaaadaaceaaaaaafeaaabaaaaaa
acababaaaaacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaahaaabaaabaaaaaaaaaa
aaaaakaaabaaacaaaaaaaaaaabacppppfbaaaaafadaaapkaaaaaaadpjkjjfjdp
mnmmmmlnaaaaaaaafbaaaaafaeaaapkadddddddpjkjjjjdoaaaaiaeaaaaaaaea
bpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaia
acaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapka
ecaaaaadaaaacpiaaaaaoelaacaioekaacaaaaadabaacpiaaaaappiaacaaaakb
agaaaaacacaaaiiaaeaapplaaeaaaaaeacaaadiaaeaaoelaacaappiaadaaaaka
ebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaaaaioekaceaaaaacabaachia
adaaoelaceaaaaacacaachiaacaaoelaaiaaaaadacaadiiaabaaoeiaacaaoeib
aiaaaaadabaacbiaabaaoelaacaaoeiaabaaaaacabaadciaabaaaaibaeaaaaae
abaacbiaabaaaaiaaeaaaakaaeaaffkaalaaaaadacaacbiaabaaaaiaadaappka
bcaaaaaeadaaciiaadaaffkaacaappiaabaaffiaacaaaaadabaacbiaaaaaffia
adaakkkaafaaaaadabaacbiaabaaaaiaadaappiaafaaaaadabaachiaabaaaaia
abaaoekaaeaaaaaeabaachiaabaaoeiaaeaakkkaacaaaaiaafaaaaadacaachia
aaaaoeiaaaaaoekaafaaaaadabaachiaabaaoeiaacaaoeiaaiaaaaadacaaadia
aeaaoelaaeaaoelaecaaaaadacaacpiaacaaoeiaabaioekaafaaaaadabaaaiia
abaappiaacaaaaiaafaaaaadabaaciiaabaappiaaeaappkafiaaaaaeabaaciia
aeaakklbadaappkaabaappiaafaaaaadaaaachiaabaappiaabaaoeiaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefckmaeaaaaeaaaaaaaclabaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaaaaaaaaajbcaabaaaabaaaaaa
dkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaakaaaaaadbaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
abaaaaaaegbcbaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaaadaaaaaa
egbcbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaabaaaaaaegbcbaaaadaaaaaabacaaaaibcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaahccaabaaa
abaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadgcaaaagecaabaaaabaaaaaa
bkaabaiaebaaaaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaadddddddpabeaaaaajkjjjjdodeaaaaahccaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaaaaaaaaaaaaaaaaaibcaabaaaabaaaaaackaabaiaebaaaaaa
abaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaajkjjfjdpckaabaaaabaaaaaaaaaaaaahecaabaaaabaaaaaabkaabaaa
aaaaaaaaabeaaaaamnmmmmlndiaaaaahbcaabaaaabaaaaaackaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaaincaabaaaabaaaaaaagaabaaaabaaaaaaagijcaaa
aaaaaaaaahaaaaaadcaaaaamhcaabaaaabaaaaaaigadbaaaabaaaaaaaceaaaaa
aaaaiaeaaaaaiaeaaaaaiaeaaaaaaaaafgafbaaaabaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaafaaaaaapgbpbaaa
afaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaa
aaaaaaaackbabaaaafaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaa
efaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
abaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaaaaaaaaaaagaabaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
ejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_VertexLitTranslucencyColor]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTextureB0] 2D
SetTexture 2 [_LightTexture0] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 29 ALU, 3 TEX
PARAM c[5] = { program.local[0..2],
		{ 4, 0, 0.85009766, 0.099975586 },
		{ 0.70019531, 0.30004883, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R2, fragment.texcoord[0], texture[0], 2D;
TEX R1.w, fragment.texcoord[4], texture[2], CUBE;
SLT R0.y, R2.w, c[2].x;
DP3 R0.x, fragment.texcoord[4], fragment.texcoord[4];
DP3 R1.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R1.x, R1.x;
MUL R1.xyz, R1.x, fragment.texcoord[3];
MOV result.color.w, R2;
TEX R0.w, R0.x, texture[1], 2D;
KIL -R0.y;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[2];
DP3 R3.x, R0, fragment.texcoord[1];
DP3_SAT R0.x, R1, -R0;
MOV_SAT R3.y, -R3.x;
ADD R0.x, R0, -R3.y;
MAD R0.y, R0.x, c[3].z, R3;
MAD R0.z, R3.x, c[4].x, c[4].y;
ADD R0.x, R2.y, -c[3].w;
MAX R1.x, R0.z, c[3].y;
MUL R0.x, R0.y, R0;
MUL R0.xyz, R0.x, c[1];
MAD R0.xyz, R0, c[3].x, R1.x;
MUL R1.xyz, R2, c[0];
MUL R0.xyz, R1, R0;
MUL R0.w, R0, R1;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[4].z;
END
# 29 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_VertexLitTranslucencyColor]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTextureB0] 2D
SetTexture 2 [_LightTexture0] CUBE
"ps_2_0
; 29 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
def c3, 0.00000000, 1.00000000, 0.70019531, 0.30004883
def c4, -0.09997559, 0.85009766, 4.00000000, 2.00000000
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
texld r2, t0, s0
add_pp r0.x, r2.w, -c2
cmp r1.x, r0, c3, c3.y
mov_pp r1, -r1.x
dp3 r0.x, t4, t4
mov r0.xy, r0.x
texld r5, r0, s1
texld r0, t4, s2
texkill r1.xyzw
dp3_pp r0.x, t2, t2
rsq_pp r1.x, r0.x
mul_pp r3.xyz, r1.x, t2
dp3_pp r0.x, t3, t3
rsq_pp r1.x, r0.x
dp3_pp r0.x, r3, t1
mul_pp r4.xyz, r1.x, t3
mov_pp_sat r1.x, -r0
dp3_pp_sat r3.x, r4, -r3
add_pp r3.x, r3, -r1
mad_pp r3.x, r3, c4.y, r1
add_pp r1.x, r2.y, c4
mad_pp r0.x, r0, c3.z, c3.w
mul_pp r1.x, r3, r1
mul_pp r1.xyz, r1.x, c1
max_pp r0.x, r0, c3
mad_pp r0.xyz, r1, c4.z, r0.x
mul_pp r1.xyz, r2, c0
mul_pp r1.xyz, r1, r0
mul r0.x, r5, r0.w
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c4.w
mov_pp r0.w, r2
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
ConstBuffer "$Globals" 176 // 164 used size, 9 vars
Vector 16 [_LightColor0] 4
Vector 112 [_VertexLitTranslucencyColor] 3
Float 160 [_Cutoff]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 0
// 30 instructions, 3 temp regs, 0 temp arrays:
// ALU 20 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedikbelmkjmgigfmjmnkgbpniljljniaaoabaaaaaadeafaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbeaeaaaa
eaaaaaaaafabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaae
aahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
aaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaa
akaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaa
egbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaabaaaaaahicaabaaa
abaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegbcbaaa
adaaaaaabacaaaaibcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaa
dgcaaaagecaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaajccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaadddddddpabeaaaaajkjjjjdodeaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaaibcaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaajkjjfjdpckaabaaaabaaaaaaaaaaaaah
ecaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaamnmmmmlndiaaaaahbcaabaaa
abaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaincaabaaaabaaaaaa
agaabaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaadcaaaaamhcaabaaaabaaaaaa
igadbaaaabaaaaaaaceaaaaaaaaaiaeaaaaaiaeaaaaaiaeaaaaaaaaafgafbaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbcbaaaafaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaagaabaaaabaaaaaapgapbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
ConstBuffer "$Globals" 176 // 164 used size, 9 vars
Vector 16 [_LightColor0] 4
Vector 112 [_VertexLitTranslucencyColor] 3
Float 160 [_Cutoff]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 0
// 30 instructions, 3 temp regs, 0 temp arrays:
// ALU 20 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_3
eefiecedffmbhbigfaafgmjbngdecoihbehpmignabaaaaaajeahaaaaaeaaaaaa
daaaaaaaimacaaaakiagaaaagaahaaaaebgpgodjfeacaaaafeacaaaaaaacpppp
aaacaaaafeaaaaaaadaadaaaaaaafeaaaaaafeaaadaaceaaaaaafeaaacaaaaaa
abababaaaaacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaahaaabaaabaaaaaaaaaa
aaaaakaaabaaacaaaaaaaaaaabacppppfbaaaaafadaaapkajkjjfjdpmnmmmmln
dddddddpjkjjjjdofbaaaaafaeaaapkaaaaaaaaaaaaaiaeaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaia
acaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaaahlabpaaaaac
aaaaaajiaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapka
ecaaaaadaaaacpiaaaaaoelaacaioekaacaaaaadabaacpiaaaaappiaacaaaakb
ebaaaaababaaapiaceaaaaacabaachiaadaaoelaceaaaaacacaachiaacaaoela
aiaaaaadacaadiiaabaaoeiaacaaoeibaiaaaaadabaacbiaabaaoelaacaaoeia
abaaaaacabaadciaabaaaaibaeaaaaaeabaacbiaabaaaaiaadaakkkaadaappka
alaaaaadacaacbiaabaaaaiaaeaaaakabcaaaaaeadaaciiaadaaaakaacaappia
abaaffiaacaaaaadabaacbiaaaaaffiaadaaffkaafaaaaadabaacbiaabaaaaia
adaappiaafaaaaadabaachiaabaaaaiaabaaoekaaeaaaaaeabaachiaabaaoeia
aeaaffkaacaaaaiaafaaaaadacaachiaaaaaoeiaaaaaoekaafaaaaadabaachia
abaaoeiaacaaoeiaaiaaaaadacaaadiaaeaaoelaaeaaoelaecaaaaadadaaapia
aeaaoelaaaaioekaecaaaaadacaaapiaacaaoeiaabaioekafkaaaaaeabaaciia
acaaaaiaadaappiaaeaaaakaafaaaaadaaaachiaabaappiaabaaoeiaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcbeaeaaaaeaaaaaaaafabaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaaaaaaaaajbcaabaaaabaaaaaa
dkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaakaaaaaadbaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
abaaaaaaegbcbaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaaadaaaaaa
egbcbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaabaaaaaaegbcbaaaadaaaaaabacaaaaibcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaahccaabaaa
abaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadgcaaaagecaabaaaabaaaaaa
bkaabaiaebaaaaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaadddddddpabeaaaaajkjjjjdodeaaaaahccaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaaaaaaaaaaaaaaaaaibcaabaaaabaaaaaackaabaiaebaaaaaa
abaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaajkjjfjdpckaabaaaabaaaaaaaaaaaaahecaabaaaabaaaaaabkaabaaa
aaaaaaaaabeaaaaamnmmmmlndiaaaaahbcaabaaaabaaaaaackaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaaincaabaaaabaaaaaaagaabaaaabaaaaaaagijcaaa
aaaaaaaaahaaaaaadcaaaaamhcaabaaaabaaaaaaigadbaaaabaaaaaaaceaaaaa
aaaaiaeaaaaaiaeaaaaaiaeaaaaaaaaafgafbaaaabaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbcbaaaafaaaaaaeghobaaa
acaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaagaabaaaabaaaaaa
pgapbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_VertexLitTranslucencyColor]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 25 ALU, 2 TEX
PARAM c[5] = { program.local[0..2],
		{ 4, 0, 0.85009766, 0.099975586 },
		{ 0.70019531, 0.30004883, 2, 0.79980469 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.w, fragment.texcoord[4], texture[1], 2D;
SLT R1.x, R0.w, c[2];
DP3 R2.x, fragment.texcoord[3], fragment.texcoord[3];
MAD R1.w, R1, c[4].z, -c[4].z;
RSQ R2.y, R2.x;
MAD R1.w, R1, c[4], c[4].z;
MOV result.color.w, R0;
KIL -R1.x;
MOV R1.xyz, fragment.texcoord[2];
DP3 R2.x, fragment.texcoord[1], R1;
MUL R1.xyz, R2.y, fragment.texcoord[3];
DP3_SAT R1.x, R1, -fragment.texcoord[2];
MOV_SAT R2.y, -R2.x;
MAD R1.z, R2.x, c[4].x, c[4].y;
ADD R1.x, R1, -R2.y;
MAD R1.y, R1.x, c[3].z, R2;
ADD R1.x, R0.y, -c[3].w;
MAX R2.x, R1.z, c[3].y;
MUL R1.x, R1.y, R1;
MUL R1.xyz, R1.x, c[1];
MAD R1.xyz, R1, c[3].x, R2.x;
MUL R0.xyz, R0, c[0];
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, R1.w;
END
# 25 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_VertexLitTranslucencyColor]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTexture0] 2D
"ps_2_0
; 25 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
def c3, 0.00000000, 1.00000000, 0.70019531, 0.30004883
def c4, -0.09997559, 0.85009766, 4.00000000, 2.00000000
def c5, 0.79980469, 2.00000000, 0, 0
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4.xy
texld r3, t0, s0
add_pp r0.x, r3.w, -c2
cmp r0.x, r0, c3, c3.y
mov_pp r0, -r0.x
mov_pp r2.xyz, t2
texkill r0.xyzw
texld r0, t4, s1
dp3_pp r0.x, t3, t3
rsq_pp r1.x, r0.x
dp3_pp r0.x, t1, r2
mul_pp r2.xyz, r1.x, t3
mov_pp_sat r1.x, -r0
dp3_pp_sat r2.x, r2, -t2
add_pp r4.x, r2, -r1
mad_pp r0.x, r0, c3.z, c3.w
add_pp r2.x, r3.y, c4
mad_pp r1.x, r4, c4.y, r1
mul_pp r1.x, r1, r2
mul_pp r2.xyz, r1.x, c1
max_pp r1.x, r0, c3
mad_pp r0.x, r0.w, c4.w, -c4.w
mad_pp r1.xyz, r2, c4.z, r1.x
mul_pp r2.xyz, r3, c0
mad_pp r0.x, r0, c5, c5.y
mul_pp r1.xyz, r2, r1
mul_pp r0.xyz, r1, r0.x
mov_pp r0.w, r3
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
ConstBuffer "$Globals" 176 // 164 used size, 9 vars
Vector 16 [_LightColor0] 4
Vector 112 [_VertexLitTranslucencyColor] 3
Float 160 [_Cutoff]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
// 26 instructions, 2 temp regs, 0 temp arrays:
// ALU 15 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedjoedadnoanlpkhgpommbopheljombdpmabaaaaaaliaeaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjiadaaaa
eaaaaaaaogaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
mcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaa
aaaaaaaaakaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
aeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaabacaaaai
bcaabaaaabaaaaaaegacbaaaabaaaaaaegbcbaiaebaaaaaaadaaaaaabaaaaaah
ccaabaaaabaaaaaaegbcbaaaacaaaaaaegbcbaaaadaaaaaadgcaaaagecaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaadddddddpabeaaaaajkjjjjdodeaaaaahccaabaaaabaaaaaa
bkaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaaibcaabaaaabaaaaaackaabaia
ebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaajkjjfjdpckaabaaaabaaaaaaaaaaaaahecaabaaaabaaaaaa
bkaabaaaaaaaaaaaabeaaaaamnmmmmlndiaaaaahbcaabaaaabaaaaaackaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaaincaabaaaabaaaaaaagaabaaaabaaaaaa
agijcaaaaaaaaaaaahaaaaaadcaaaaamhcaabaaaabaaaaaaigadbaaaabaaaaaa
aceaaaaaaaaaiaeaaaaaiaeaaaaaiaeaaaaaaaaafgafbaaaabaaaaaadiaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaaamadcaaaaajicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaamnmmemdpabeaaaaaaaaaaaeadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
ConstBuffer "$Globals" 176 // 164 used size, 9 vars
Vector 16 [_LightColor0] 4
Vector 112 [_VertexLitTranslucencyColor] 3
Float 160 [_Cutoff]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
// 26 instructions, 2 temp regs, 0 temp arrays:
// ALU 15 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_3
eefiecedahomcfboejpgammkjgkbjnppdkcdnnffabaaaaaabeahaaaaaeaaaaaa
daaaaaaaiiacaaaaciagaaaaoaagaaaaebgpgodjfaacaaaafaacaaaaaaacpppp
aaacaaaafaaaaaaaadaacmaaaaaafaaaaaaafaaaacaaceaaaaaafaaaabaaaaaa
aaababaaaaaaabaaabaaaaaaaaaaaaaaaaaaahaaabaaabaaaaaaaaaaaaaaakaa
abaaacaaaaaaaaaaabacppppfbaaaaafadaaapkajkjjfjdpmnmmmmlndddddddp
jkjjjjdofbaaaaafaeaaapkaaaaaaaaaaaaaiaeaaaaaaaeaaaaaaamafbaaaaaf
afaaapkamnmmemdpaaaaaaeaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaia
adaachlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaacpiaaaaaoelaabaioekaacaaaaadabaacpiaaaaappiaacaaaakbabaaaaac
acaaadiaaaaaollaebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaaaaioeka
ceaaaaacabaachiaadaaoelaaiaaaaadabaadbiaabaaoeiaacaaoelbabaaaaac
acaaahiaacaaoelaaiaaaaadabaacciaabaaoelaacaaoeiaabaaaaacabaadeia
abaaffibaeaaaaaeabaacciaabaaffiaadaakkkaadaappkaalaaaaadacaacbia
abaaffiaaeaaaakabcaaaaaeacaacciaadaaaakaabaaaaiaabaakkiaacaaaaad
abaacbiaaaaaffiaadaaffkaafaaaaadabaacbiaabaaaaiaacaaffiaafaaaaad
abaachiaabaaaaiaabaaoekaaeaaaaaeabaachiaabaaoeiaaeaaffkaacaaaaia
afaaaaadacaachiaaaaaoeiaaaaaoekaafaaaaadabaachiaabaaoeiaacaaoeia
aeaaaaaeabaaciiaabaappiaaeaakkkaaeaappkaaeaaaaaeabaaciiaabaappia
afaaaakaafaaffkaafaaaaadaaaachiaabaappiaabaaoeiaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcjiadaaaaeaaaaaaaogaaaaaafjaaaaaeegiocaaa
aaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaajbcaabaaaabaaaaaa
dkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaakaaaaaadbaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
abaaaaaaegbcbaaaaeaaaaaabacaaaaibcaabaaaabaaaaaaegacbaaaabaaaaaa
egbcbaiaebaaaaaaadaaaaaabaaaaaahccaabaaaabaaaaaaegbcbaaaacaaaaaa
egbcbaaaadaaaaaadgcaaaagecaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaa
dcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaadddddddpabeaaaaa
jkjjjjdodeaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaa
aaaaaaaibcaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaa
dcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaajkjjfjdpckaabaaa
abaaaaaaaaaaaaahecaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaamnmmmmln
diaaaaahbcaabaaaabaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaai
ncaabaaaabaaaaaaagaabaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaadcaaaaam
hcaabaaaabaaaaaaigadbaaaabaaaaaaaceaaaaaaaaaiaeaaaaaiaeaaaaaiaea
aaaaaaaafgafbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
dcaaaaajicaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaeaabeaaaaa
aaaaaamadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaamnmmemdp
abeaaaaaaaaaaaeadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaaamamaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

}
	}
	Pass {
		Name "PREPASS"
		Tags { "LightMode" = "PrePassBase" }
		Fog {Mode Off}
Program "vp" {
// Vertex combos: 1
//   opengl - ALU: 40 to 40
//   d3d9 - ALU: 42 to 42
//   d3d11 - ALU: 22 to 22, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 22 to 22, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 13 [_Time]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 14 [unity_Scale]
Vector 15 [_Color]
Vector 16 [_MainTex_ST]
"!!ARBvp1.0
# 40 ALU
PARAM c[24] = { { 2, 1, 6.4088488, 3.1415927 },
		state.matrix.mvp,
		program.local[5..16],
		{ 1.2, 2, 1.6, 4.8000002 },
		{ 0.048, 0.059999999, 0.23999999, 0.096000001 },
		{ 0.024, 0.079999998, 0.2, -0.00019840999 },
		{ 0.0083333002, -0.16161616, 0 },
		{ 0.21538745, 0.35897908, 0.28718325, 0.86154979 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[0];
MAD R1.x, R0, -c[15].z, -vertex.color.z;
MUL R2.xyz, vertex.position.z, c[19];
ADD R1.x, R1, c[0].y;
MAD R0, vertex.position.x, c[18], R2.xyyz;
ADD R1.y, vertex.color, c[15];
MUL R1.x, R1, c[13];
MUL R1.x, R1, R1.y;
MAD R0, R1.x, c[17], R0;
FRC R0, R0;
MAD R0, R0, c[0].z, -c[0].w;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[20].y, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[20].x, R0;
ADD R3.x, vertex.color.w, c[15].w;
MAD R0, R1, c[19].w, R0;
MUL R2.x, vertex.texcoord[0].y, R3;
MUL R0, R0, R2.x;
MUL R0, R0, c[21];
MUL R0, R0, R0;
MUL R1, R0, R0;
DP4 R0.z, R1, c[22];
DP4 R0.x, R1, c[23];
MOV R0.y, c[20].z;
DP3 R1.y, R0, c[11];
DP3 R1.x, R0, c[9];
ADD R0.xz, vertex.position, -R1.xyyw;
MOV R0.yw, vertex.position;
MUL R1.xyz, vertex.normal, c[14].w;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
END
# 40 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_Time]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_Color]
Vector 15 [_MainTex_ST]
"vs_2_0
; 42 ALU
def c16, 2.00000000, 1.00000000, 6.40884876, -3.14159274
def c17, 0.02400000, 0.08000000, 0.20000000, -0.16161616
def c18, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c19, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c20, 0.00833330, -0.00019841, 0.00000000, 0
def c21, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c22, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c23, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.x, c14.z
mad r1.x, c16, -r0, -v5.z
mul r2.xyz, v0.z, c17
add r1.x, r1, c16.y
mad r0, v0.x, c18, r2.xyyz
add r1.y, v5, c14
mul r1.x, r1, c12
mul r1.x, r1, r1.y
mad r0, r1.x, c19, r0
frc r0, r0
mad r0, r0, c16.z, c16.w
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c17.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c20.x, r0
add r3.x, v5.w, c14.w
mad r0, r1, c20.y, r0
mul r2.x, v3.y, r3
mul r0, r0, r2.x
mul r0, r0, c21
mul r0, r0, r0
mul r1, r0, r0
dp4 r0.z, r1, c22
dp4 r0.x, r1, c23
mov r0.y, c20.z
dp3 r1.y, r0, c10
dp3 r1.x, r0, c8
add r0.xz, v0, -r1.xyyw
mov r0.yw, v0
mul r1.xyz, v2, c13.w
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
dp3 oT1.z, r1, c6
dp3 oT1.y, r1, c5
dp3 oT1.x, r1, c4
mad oT0.xy, v3, c15, c15.zwzw
"
}

SubProgram "d3d11 " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 112 // 96 used size, 8 vars
Vector 64 [_Color] 4
Vector 80 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 37 instructions, 4 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedofnnjokkhffpicpncnpcachkfdhajoahabaaaaaacmahaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcmaafaaaaeaaaabaahaabaaaafjaaaaaeegiocaaaaaaaaaaa
agaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadocbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaac
aeaaaaaadiaaaaakpcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedm
aknhkddnaknhkddnmnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaa
aceaaaaakgjleednipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaal
bcaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaea
abeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaia
ebaaaaaaafaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaa
abaaaaaaaaaaaaaaaaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaa
aaaaaaaaaeaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaa
dcaaaaampcaabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaea
mnmmmmdpjkjjjjeaegaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmnea
ekbfmneaekbfmneaekbfmneaaceaaaaanlapejmanlapejmanlapejmanlapejma
diaaaaahpcaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaah
pcaabaaaadaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaadaaaaaaaceaaaaalfhocflolfhocflolfhocflolfhocflo
egaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
adaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidm
gfiiaidmgfiiaidmegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
acaaaaaaaceaaaaaehamfaljehamfaljehamfaljehamfaljegaobaaaaaaaaaaa
diaaaaahpcaabaaaaaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaak
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddo
ihiofmdpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaak
bcaabaaaabaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlm
mnmmmmdnbbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedm
aknhcddnipmcpflnkgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaa
agiccaaaacaaaaaabcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaaacaaaaaa
baaaaaaaagaabaaaaaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaa
egaabaiaebaaaaaaaaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaacaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadoaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 112 // 96 used size, 8 vars
Vector 64 [_Color] 4
Vector 80 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 37 instructions, 4 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_3
eefiecedhlnghalldgjjfaiblnhjaffngdlgfinnabaaaaaaemalaaaaaeaaaaaa
daaaaaaaemaeaaaabeakaaaanmakaaaaebgpgodjbeaeaaaabeaeaaaaaaacpopp
jiadaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaaeaa
acaaabaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaaacaaaaaaaeaaaeaaaaaaaaaa
acaaamaaadaaaiaaaaaaaaaaacaabaaaabaaalaaaaaaaaaaacaabcaaabaaamaa
aaaaaaaaacaabeaaabaaanaaaaaaaaaaaaaaaaaaabacpoppfbaaaaafaoaaapka
kgjleednipmchfdnipmchfdokgjlmednfbaaaaafapaaapkakgjlmedmaknhkddn
mnmmemdolfhocflofbaaaaafbaaaapkaaaaaaaeaaaaaiadpekbfmneanlapejma
fbaaaaafbbaaapkajkjjjjdpaaaaaaeamnmmmmdpjkjjjjeafbaaaaafbcaaapka
gfiiaidmehamfaljaaaaaaaaaaaaaaaafbaaaaafbdaaapkaihiofmdoblmmlhdo
kpajjddoihiofmdpfbaaaaafbeaaapkakgjlmedmaknhcddnipmcpflnkgjlmedn
fbaaaaafbfaaapkakgjlmedlaknhkddmaknhkdlmmnmmmmdnbpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
afaaafiaafaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaafaaaaad
aaaaahiaacaaoejaanaappkaafaaaaadabaaahiaaaaaffiaajaaoekaaeaaaaae
aaaaaliaaiaakekaaaaaaaiaabaakeiaaeaaaaaeabaaahoaakaaoekaaaaakkia
aaaapeiaafaaaaadaaaaapiaaaaakkjaapaajekaaeaaaaaeaaaaapiaaaaaaaja
aoaaoekaaaaaoeiaabaaaaacabaaadiabaaaoekaaeaaaaaeabaaabiaabaakkka
abaaaaibabaaffiaacaaaaadabaaabiaabaaaaiaafaakkjbafaaaaadabaaabia
abaaaaiaadaaaakaacaaaaadabaaagiaafaapejaabaapekaafaaaaadabaaabia
abaaffiaabaaaaiaafaaaaadabaaaciaabaakkiaadaaffjaaeaaaaaeaaaaapia
abaaaaiabbaaoekaaaaaoeiabdaaaaacaaaaapiaaaaaoeiaaeaaaaaeaaaaapia
aaaaoeiabaaakkkabaaappkaafaaaaadacaaapiaaaaaoeiaaaaaoeiaafaaaaad
adaaapiaaaaaoeiaacaaoeiaaeaaaaaeaaaaapiaadaaoeiaapaappkaaaaaoeia
afaaaaadadaaapiaacaaoeiaadaaoeiaafaaaaadacaaapiaacaaoeiaadaaoeia
aeaaaaaeaaaaapiaadaaoeiabcaaaakaaaaaoeiaaeaaaaaeaaaaapiaacaaoeia
bcaaffkaaaaaoeiaafaaaaadaaaaapiaabaaffiaaaaaoeiaafaaaaadaaaaapia
aaaaoeiabdaaoekaafaaaaadaaaaapiaaaaaoeiaaaaaoeiaafaaaaadaaaaapia
aaaaoeiaaaaaoeiaajaaaaadabaaabiaaaaaoeiabfaaoekaajaaaaadaaaaabia
aaaaoeiabeaaoekaafaaaaadaaaaagiaabaaaaiaamaaoakaaeaaaaaeaaaaadia
alaaoikaaaaaaaiaaaaaojiaacaaaaadaaaaadiaaaaaoeibaaaaoijaafaaaaad
abaaapiaaaaaffjaafaaoekaaeaaaaaeabaaapiaaeaaoekaaaaaaaiaabaaoeia
aeaaaaaeaaaaapiaagaaoekaaaaaffiaabaaoeiaaeaaaaaeaaaaapiaahaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiappppaaaafdeieefcmaafaaaaeaaaabaahaabaaaafjaaaaae
egiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaae
egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadocbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagiaaaaacaeaaaaaadiaaaaakpcaabaaaaaaaaaaakgbkbaaaaaaaaaaa
aceaaaaakgjlmedmaknhkddnaknhkddnmnmmemdodcaaaaampcaabaaaaaaaaaaa
agbabaaaaaaaaaaaaceaaaaakgjleednipmchfdnipmchfdokgjlmednegaobaaa
aaaaaaaadcaaaaalbcaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaa
abeaaaaaaaaaaaeaabeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaackbabaiaebaaaaaaafaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaaakiacaaaabaaaaaaaaaaaaaaaaaaaaaigcaabaaaabaaaaaafgbhbaaa
afaaaaaafgihcaaaaaaaaaaaaeaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaabaaaaaa
bkbabaaaadaaaaaadcaaaaampcaabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaa
jkjjjjdpaaaaaaeamnmmmmdpjkjjjjeaegaobaaaaaaaaaaabkaaaaafpcaabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaaekbfmneaekbfmneaekbfmneaekbfmneaaceaaaaanlapejmanlapejma
nlapejmanlapejmadiaaaaahpcaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaalfhocflolfhocflo
lfhocflolfhocfloegaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaadaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaa
gfiiaidmgfiiaidmgfiiaidmgfiiaidmegaobaaaaaaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaacaaaaaaaceaaaaaehamfaljehamfaljehamfaljehamfalj
egaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaafgafbaaaabaaaaaaegaobaaa
aaaaaaaadiaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaihiofmdo
blmmlhdokpajjddoihiofmdpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
aaaaaaaabbaaaaakbcaabaaaabaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedl
aknhkddmaknhkdlmmnmmmmdnbbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaakgjlmedmaknhcddnipmcpflnkgjlmedndiaaaaaigcaabaaaaaaaaaaa
agaabaaaabaaaaaaagiccaaaacaaaaaabcaaaaaadcaaaaakdcaabaaaaaaaaaaa
igiacaaaacaaaaaabaaaaaaaagaabaaaaaaaaaaajgafbaaaaaaaaaaaaaaaaaai
dcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaaigbabaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaafgafbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
giaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}

}
Program "fp" {
// Fragment combos: 1
//   opengl - ALU: 5 to 5, TEX: 1 to 1
//   d3d9 - ALU: 6 to 6, TEX: 2 to 2
//   d3d11 - ALU: 2 to 2, TEX: 1 to 1, FLOW: 1 to 1
//   d3d11_9x - ALU: 2 to 2, TEX: 1 to 1, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 5 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 0, 0.5 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
SLT R0.x, R0.w, c[0];
MAD result.color.xyz, fragment.texcoord[1], c[1].y, c[1].y;
MOV result.color.w, c[1].x;
KIL -R0.x;
END
# 5 instructions, 1 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 6 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 0.50000000, 0
dcl t0.xy
dcl t1.xyz
texld r0, t0, s0
add_pp r0.x, r0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
mad_pp r0.xyz, t1, c1.z, c1.z
mov_pp r0.w, c1.x
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { }
ConstBuffer "$Globals" 112 // 100 used size, 8 vars
Float 96 [_Cutoff]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
// 7 instructions, 1 temp regs, 0 temp arrays:
// ALU 2 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkcjkpmckdppallofhbmdfbkkphoaklogabaaaaaapmabaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcceabaaaaeaaaaaaaejaaaaaa
fjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaaj
bcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaagaaaaaa
dbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaaaaaaaaadcaaaaaphccabaaaaaaaaaaaegbcbaaaacaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { }
ConstBuffer "$Globals" 112 // 100 used size, 8 vars
Float 96 [_Cutoff]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
// 7 instructions, 1 temp regs, 0 temp arrays:
// ALU 2 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_3
eefiecedpcncaapibdlncplhmkpgokgphpgglmceabaaaaaamiacaaaaaeaaaaaa
daaaaaaapiaaaaaaceacaaaajeacaaaaebgpgodjmaaaaaaamaaaaaaaaaacpppp
imaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaagaaabaaaaaaaaaaaaaaabacppppfbaaaaafabaaapkaaaaaaadpaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaiaabaachla
bpaaaaacaaaaaajaaaaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaacaaaaad
aaaacpiaaaaappiaaaaaaakbebaaaaabaaaaapiaaeaaaaaeaaaacpiaabaacela
abaaeakaabaaeakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcceabaaaa
eaaaaaaaejaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaa
aaaaaaaaagaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaaaaaaaaadcaaaaaphccabaaaaaaaaaaaegbcbaaa
acaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}

}
	}
	Pass {
		Name "PREPASS"
		Tags { "LightMode" = "PrePassFinal" }
		ZWrite Off
Program "vp" {
// Vertex combos: 4
//   opengl - ALU: 50 to 59
//   d3d9 - ALU: 53 to 61
//   d3d11 - ALU: 30 to 34, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 30 to 34, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 13 [_Time]
Vector 14 [_ProjectionParams]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [_Color]
Vector 24 [_MainTex_ST]
"!!ARBvp1.0
# 59 ALU
PARAM c[32] = { { 2, 1, 6.4088488, 3.1415927 },
		state.matrix.mvp,
		program.local[5..24],
		{ 1.2, 2, 1.6, 4.8000002 },
		{ 0.048, 0.059999999, 0.23999999, 0.096000001 },
		{ 0.024, 0.079999998, 0.2, -0.00019840999 },
		{ 0.0083333002, -0.16161616, 0, 0.5 },
		{ 0.21538745, 0.35897908, 0.28718325, 0.86154979 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[0];
MAD R1.x, R0, -c[23].z, -vertex.color.z;
MUL R2.xyz, vertex.position.z, c[27];
ADD R1.x, R1, c[0].y;
MAD R0, vertex.position.x, c[26], R2.xyyz;
ADD R1.y, vertex.color, c[23];
MUL R1.x, R1, c[13];
MUL R1.x, R1, R1.y;
MAD R0, R1.x, c[25], R0;
FRC R0, R0;
MAD R0, R0, c[0].z, -c[0].w;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[28].y, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[28].x, R0;
MAD R0, R1, c[27].w, R0;
ADD R3.x, vertex.color.w, c[23].w;
MUL R2.x, vertex.texcoord[0].y, R3;
MUL R0, R0, R2.x;
MUL R0, R0, c[29];
MUL R0, R0, R0;
MUL R0, R0, R0;
DP4 R1.z, R0, c[30];
DP4 R1.x, R0, c[31];
MOV R1.y, c[28].z;
DP3 R0.y, R1, c[11];
DP3 R0.x, R1, c[9];
ADD R1.xz, vertex.position, -R0.xyyw;
MOV R1.yw, vertex.position;
DP4 R0.w, R1, c[4];
DP4 R0.z, R1, c[3];
DP4 R0.x, R1, c[1];
DP4 R0.y, R1, c[2];
MUL R2.xyz, R0.xyww, c[28].w;
MUL R1.xyz, vertex.normal, c[22].w;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
DP3 R2.w, R1, c[6];
MUL R2.y, R2, c[14].x;
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
ADD result.texcoord[1].xy, R2, R2.z;
DP4 R2.z, R0, c[17];
DP4 R2.y, R0, c[16];
DP4 R2.x, R0, c[15];
MUL R0.w, R2, R2;
MAD R0.w, R0.x, R0.x, -R0;
DP4 R0.z, R1, c[20];
DP4 R0.y, R1, c[19];
DP4 R0.x, R1, c[18];
MUL R1.xyz, R0.w, c[21];
ADD R0.xyz, R2, R0;
ADD result.texcoord[2].xyz, R0, R1;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
END
# 59 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_Time]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [_Color]
Vector 24 [_MainTex_ST]
"vs_2_0
; 61 ALU
def c25, 2.00000000, 1.00000000, 6.40884876, -3.14159274
def c26, 0.02400000, 0.08000000, 0.20000000, -0.16161616
def c27, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c28, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c29, 0.00833330, -0.00019841, 0.00000000, 0.50000000
def c30, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c31, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c32, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.x, c23.z
mad r1.x, c25, -r0, -v5.z
mul r2.xyz, v0.z, c26
add r1.x, r1, c25.y
mad r0, v0.x, c27, r2.xyyz
add r1.y, v5, c23
mul r1.x, r1, c12
mul r1.x, r1, r1.y
mad r0, r1.x, c28, r0
frc r0, r0
mad r0, r0, c25.z, c25.w
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c26.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c29.x, r0
mad r0, r1, c29.y, r0
add r3.x, v5.w, c23.w
mul r2.x, v3.y, r3
mul r0, r0, r2.x
mul r0, r0, c30
mul r0, r0, r0
mul r0, r0, r0
dp4 r1.z, r0, c31
dp4 r1.x, r0, c32
mov r1.y, c29.z
dp3 r0.y, r1, c10
dp3 r0.x, r1, c8
add r1.xz, v0, -r0.xyyw
mov r1.yw, v0
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r2.xyz, r0.xyww, c29.w
mul r1.xyz, v2, c22.w
mov oPos, r0
mov oT1.zw, r0
dp3 r2.w, r1, c5
mul r2.y, r2, c13.x
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c25.y
mad oT1.xy, r2.z, c14.zwzw, r2
dp4 r2.z, r0, c17
dp4 r2.y, r0, c16
dp4 r2.x, r0, c15
mul r0.w, r2, r2
mad r0.w, r0.x, r0.x, -r0
dp4 r0.z, r1, c20
dp4 r0.y, r1, c19
dp4 r0.x, r1, c18
mul r1.xyz, r0.w, c21
add r0.xyz, r2, r0
add oT2.xyz, r0, r1
mad oT0.xy, v3, c24, c24.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 128 // 96 used size, 9 vars
Vector 64 [_Color] 4
Vector 80 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 0 [_Time] 4
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 54 instructions, 4 temp regs, 0 temp arrays:
// ALU 34 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcbiimgdinfdfadbemakihciomoomjfnpabaaaaaageajaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oaahaaaaeaaaabaapiabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabjaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadocbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacaeaaaaaadiaaaaakpcaabaaa
aaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedmaknhkddnaknhkddnmnmmemdo
dcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaaaceaaaaakgjleednipmchfdn
ipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaackiacaia
ebaaaaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaiadpaaaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaafaaaaaadiaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaaaaaaaaai
gcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaaaaaaaaaaaeaaaaaadiaaaaah
bcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaa
abaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaadcaaaaampcaabaaaaaaaaaaa
agaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdpjkjjjjeaegaobaaa
aaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaappcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmneaekbfmneaekbfmneaekbfmnea
aceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaahpcaabaaaacaaaaaa
egaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaa
aaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaa
aceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaaaaaaaaaadiaaaaah
pcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaa
acaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidmgfiiaidmegaobaaa
aaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaaehamfalj
ehamfaljehamfaljehamfaljegaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
fgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddoihiofmdpdiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaaegaobaaa
aaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdnbbaaaaakbcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedmaknhcddnipmcpflnkgjlmedn
diaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaaagiccaaaadaaaaaabcaaaaaa
dcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaabaaaaaaaagaabaaaaaaaaaaa
jgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaa
igbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaai
bcaabaaaabaaaaaaegiocaaaacaaaaaabcaaaaaaegaobaaaaaaaaaaabbaaaaai
ccaabaaaabaaaaaaegiocaaaacaaaaaabdaaaaaaegaobaaaaaaaaaaabbaaaaai
ecaabaaaabaaaaaaegiocaaaacaaaaaabeaaaaaaegaobaaaaaaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaacaaaaaabfaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaacaaaaaabgaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaacaaaaaabhaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaacaaaaaabiaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
doaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 128 // 96 used size, 9 vars
Vector 64 [_Color] 4
Vector 80 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 0 [_Time] 4
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 54 instructions, 4 temp regs, 0 temp arrays:
// ALU 34 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_3
eefiecedkmjnlbhmanbgajgfndkkehfgifojhdpkabaaaaaakmaoaaaaaeaaaaaa
daaaaaaaheafaaaafmanaaaaceaoaaaaebgpgodjdmafaaaadmafaaaaaaacpopp
kiaeaaaajeaaaaaaajaaceaaaaaajaaaaaaajaaaaaaaceaaabaajaaaaaaaaeaa
acaaabaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaaabaaafaaabaaaeaaaaaaaaaa
acaabcaaahaaafaaaaaaaaaaadaaaaaaaeaaamaaaaaaaaaaadaaamaaadaabaaa
aaaaaaaaadaabaaaabaabdaaaaaaaaaaadaabcaaabaabeaaaaaaaaaaadaabeaa
abaabfaaaaaaaaaaaaaaaaaaabacpoppfbaaaaafbgaaapkakgjleednipmchfdn
ipmchfdokgjlmednfbaaaaafbhaaapkakgjlmedmaknhkddnmnmmemdolfhocflo
fbaaaaafbiaaapkaaaaaaaeaaaaaiadpekbfmneanlapejmafbaaaaafbjaaapka
jkjjjjdpaaaaaaeamnmmmmdpjkjjjjeafbaaaaafbkaaapkagfiiaidmehamfalj
aaaaaadpaaaaaaaafbaaaaafblaaapkaihiofmdoblmmlhdokpajjddoihiofmdp
fbaaaaafbmaaapkakgjlmedmaknhcddnipmcpflnkgjlmednfbaaaaafbnaaapka
kgjlmedlaknhkddmaknhkdlmmnmmmmdnbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaafiaafaaapja
aeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaafaaaaadaaaaapiaaaaakkja
bhaajekaaeaaaaaeaaaaapiaaaaaaajabgaaoekaaaaaoeiaabaaaaacabaaadia
biaaoekaaeaaaaaeabaaabiaabaakkkaabaaaaibabaaffiaacaaaaadabaaabia
abaaaaiaafaakkjbafaaaaadabaaabiaabaaaaiaadaaaakaacaaaaadabaaagia
afaapejaabaapekaafaaaaadabaaabiaabaaffiaabaaaaiaafaaaaadabaaacia
abaakkiaadaaffjaaeaaaaaeaaaaapiaabaaaaiabjaaoekaaaaaoeiabdaaaaac
aaaaapiaaaaaoeiaaeaaaaaeaaaaapiaaaaaoeiabiaakkkabiaappkaafaaaaad
acaaapiaaaaaoeiaaaaaoeiaafaaaaadadaaapiaaaaaoeiaacaaoeiaaeaaaaae
aaaaapiaadaaoeiabhaappkaaaaaoeiaafaaaaadadaaapiaacaaoeiaadaaoeia
afaaaaadacaaapiaacaaoeiaadaaoeiaaeaaaaaeaaaaapiaadaaoeiabkaaaaka
aaaaoeiaaeaaaaaeaaaaapiaacaaoeiabkaaffkaaaaaoeiaafaaaaadaaaaapia
abaaffiaaaaaoeiaafaaaaadaaaaapiaaaaaoeiablaaoekaafaaaaadaaaaapia
aaaaoeiaaaaaoeiaafaaaaadaaaaapiaaaaaoeiaaaaaoeiaajaaaaadabaaabia
aaaaoeiabnaaoekaajaaaaadaaaaabiaaaaaoeiabmaaoekaafaaaaadaaaaagia
abaaaaiabeaaoakaaeaaaaaeaaaaadiabdaaoikaaaaaaaiaaaaaojiaacaaaaad
aaaaadiaaaaaoeibaaaaoijaafaaaaadabaaapiaaaaaffjaanaaoekaaeaaaaae
abaaapiaamaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaapiaaoaaoekaaaaaffia
abaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaappjaaaaaoeiaafaaaaadabaaabia
aaaaffiaaeaaaakaafaaaaadabaaaiiaabaaaaiabkaakkkaafaaaaadabaaafia
aaaapeiabkaakkkaacaaaaadabaaadoaabaakkiaabaaomiaafaaaaadabaaahia
acaaoejabfaappkaafaaaaadacaaahiaabaaffiabbaaoekaaeaaaaaeabaaalia
baaakekaabaaaaiaacaakeiaaeaaaaaeabaaahiabcaaoekaabaakkiaabaapeia
abaaaaacabaaaiiabiaaffkaajaaaaadacaaabiaafaaoekaabaaoeiaajaaaaad
acaaaciaagaaoekaabaaoeiaajaaaaadacaaaeiaahaaoekaabaaoeiaafaaaaad
adaaapiaabaacjiaabaakeiaajaaaaadaeaaabiaaiaaoekaadaaoeiaajaaaaad
aeaaaciaajaaoekaadaaoeiaajaaaaadaeaaaeiaakaaoekaadaaoeiaacaaaaad
acaaahiaacaaoeiaaeaaoeiaafaaaaadabaaaciaabaaffiaabaaffiaaeaaaaae
abaaabiaabaaaaiaabaaaaiaabaaffibaeaaaaaeacaaahoaalaaoekaabaaaaia
acaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacabaaamoaaaaaoeiappppaaaafdeieefcoaahaaaaeaaaabaa
piabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabjaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadocbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacaeaaaaaadiaaaaakpcaabaaaaaaaaaaakgbkbaaa
aaaaaaaaaceaaaaakgjlmedmaknhkddnaknhkddnmnmmemdodcaaaaampcaabaaa
aaaaaaaaagbabaaaaaaaaaaaaceaaaaakgjleednipmchfdnipmchfdokgjlmedn
egaobaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaa
aeaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaa
akaabaaaabaaaaaackbabaiaebaaaaaaafaaaaaadiaaaaaibcaabaaaabaaaaaa
akaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaaaaaaaaaigcaabaaaabaaaaaa
fgbhbaaaafaaaaaafgihcaaaaaaaaaaaaeaaaaaadiaaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaackaabaaa
abaaaaaabkbabaaaadaaaaaadcaaaaampcaabaaaaaaaaaaaagaabaaaabaaaaaa
aceaaaaajkjjjjdpaaaaaaeamnmmmmdpjkjjjjeaegaobaaaaaaaaaaabkaaaaaf
pcaabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaappcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaekbfmneaekbfmneaekbfmneaekbfmneaaceaaaaanlapejma
nlapejmanlapejmanlapejmadiaaaaahpcaabaaaacaaaaaaegaobaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaaaaaaaaaegaobaaa
acaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaalfhocflo
lfhocflolfhocflolfhocfloegaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaa
aceaaaaagfiiaidmgfiiaidmgfiiaidmgfiiaidmegaobaaaaaaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaaehamfaljehamfaljehamfalj
ehamfaljegaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaafgafbaaaabaaaaaa
egaobaaaaaaaaaaadiaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
ihiofmdoblmmlhdokpajjddoihiofmdpdiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaaegaobaaaaaaaaaaaaceaaaaa
kgjlmedlaknhkddmaknhkdlmmnmmmmdnbbaaaaakbcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaakgjlmedmaknhcddnipmcpflnkgjlmedndiaaaaaigcaabaaa
aaaaaaaaagaabaaaabaaaaaaagiccaaaadaaaaaabcaaaaaadcaaaaakdcaabaaa
aaaaaaaaigiacaaaadaaaaaabaaaaaaaagaabaaaaaaaaaaajgafbaaaaaaaaaaa
aaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaaigbabaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
fgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
adaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaa
egiocaaaacaaaaaabcaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaa
egiocaaaacaaaaaabdaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaa
egiocaaaacaaaaaabeaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
acaaaaaabfaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
acaaaaaabgaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
acaaaaaabhaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaa
acaaaaaabiaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaoaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Vector 17 [_Time]
Vector 18 [_ProjectionParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Matrix 9 [_Object2World]
Matrix 13 [_World2Object]
Vector 20 [_Color]
Vector 21 [unity_LightmapST]
Vector 22 [_MainTex_ST]
"!!ARBvp1.0
# 50 ALU
PARAM c[30] = { { 2, 1, 6.4088488, 3.1415927 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..22],
		{ 1.2, 2, 1.6, 4.8000002 },
		{ 0.048, 0.059999999, 0.23999999, 0.096000001 },
		{ 0.024, 0.079999998, 0.2, -0.00019840999 },
		{ 0.0083333002, -0.16161616, 0, 0.5 },
		{ 0.21538745, 0.35897908, 0.28718325, 0.86154979 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R3.xy, c[0];
MAD R1.x, R3, -c[20].z, -vertex.color.z;
MUL R0.xyz, vertex.position.z, c[25];
ADD R1.x, R1, c[0].y;
ADD R1.y, vertex.color, c[20];
MUL R1.x, R1, c[17];
MUL R1.x, R1, R1.y;
MAD R0, vertex.position.x, c[24], R0.xyyz;
MAD R0, R1.x, c[23], R0;
FRC R0, R0;
MAD R0, R0, c[0].z, -c[0].w;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[26].y, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[26].x, R0;
MAD R0, R1, c[25].w, R0;
ADD R3.x, vertex.color.w, c[20].w;
MUL R2.x, vertex.texcoord[0].y, R3;
MUL R0, R0, R2.x;
MUL R0, R0, c[27];
MUL R0, R0, R0;
MUL R0, R0, R0;
DP4 R1.z, R0, c[28];
DP4 R1.x, R0, c[29];
MOV R1.y, c[26].z;
DP3 R0.y, R1, c[15];
DP3 R0.x, R1, c[13];
ADD R1.xz, vertex.position, -R0.xyyw;
MOV R1.yw, vertex.position;
DP4 R0.w, R1, c[8];
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
MUL R2.xyz, R0.xyww, c[26].w;
MOV result.position, R0;
MUL R2.y, R2, c[18].x;
ADD result.texcoord[1].xy, R2, R2.z;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
ADD R2.xyz, R2, -c[19];
ADD R0.y, R3, -c[19].w;
DP4 R0.x, R1, c[3];
MOV result.texcoord[1].zw, R0;
MUL result.texcoord[3].xyz, R2, c[19].w;
MUL result.texcoord[3].w, -R0.x, R0.y;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[21], c[21].zwzw;
END
# 50 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 16 [_Time]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Matrix 8 [_Object2World]
Matrix 12 [_World2Object]
Vector 20 [_Color]
Vector 21 [unity_LightmapST]
Vector 22 [_MainTex_ST]
"vs_2_0
; 53 ALU
def c23, 2.00000000, 0.02400000, 0.08000000, 0.20000000
def c24, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c25, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c26, 6.40884876, -3.14159274, -0.16161616, 0.00833330
def c27, -0.00019841, 0.00000000, 0.50000000, 1.00000000
def c28, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c29, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c30, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r0.x, c20.z
mad r1.x, c23, -r0, -v5.z
mul r2.xyz, v0.z, c23.yzww
add r1.x, r1, c27.w
mad r0, v0.x, c24, r2.xyyz
add r1.y, v5, c20
mul r1.x, r1, c16
mul r1.x, r1, r1.y
mad r0, r1.x, c25, r0
frc r0, r0
mad r0, r0, c26.x, c26.y
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c26.z, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c26.w, r0
mad r0, r1, c27.x, r0
add r3.x, v5.w, c20.w
mul r2.x, v3.y, r3
mul r0, r0, r2.x
mul r0, r0, c28
mul r0, r0, r0
mul r0, r0, r0
dp4 r1.z, r0, c29
dp4 r1.x, r0, c30
mov r1.y, c27
dp3 r0.y, r1, c14
dp3 r0.x, r1, c12
add r1.xz, v0, -r0.xyyw
mov r1.yw, v0
dp4 r0.w, r1, c7
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mul r2.xyz, r0.xyww, c27.z
mov oPos, r0
mul r2.y, r2, c17.x
mov oT1.zw, r0
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad oT1.xy, r2.z, c18.zwzw, r2
dp4 r0.z, r1, c10
add r2.xyz, r0, -c19
mov r0.x, c19.w
add r0.y, c27.w, -r0.x
dp4 r0.x, r1, c2
mul oT3.xyz, r2, c19.w
mul oT3.w, -r0.x, r0.y
mad oT0.xy, v3, c22, c22.zwzw
mad oT2.xy, v4, c21, c21.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 160 // 112 used size, 11 vars
Vector 64 [_Color] 4
Vector 80 [unity_LightmapST] 4
Vector 96 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 0 [_Time] 4
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 416 used size, 8 vars
Vector 400 [unity_ShadowFadeCenterAndType] 4
ConstBuffer "UnityPerDraw" 336 // 320 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityShadows" 2
BindCB "UnityPerDraw" 3
// 52 instructions, 4 temp regs, 0 temp arrays:
// ALU 30 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecednpcbgilnbppiopefmhoejfngcamemigfabaaaaaaiaajaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeahaaaaeaaaabaa
pjabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaa
bdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaafpaaaaadocbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacaeaaaaaadiaaaaak
pcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedmaknhkddnaknhkddn
mnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaaaceaaaaakgjleedn
ipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaiadp
aaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaafaaaaaa
diaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaa
aaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaaaaaaaaaaaeaaaaaa
diaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaadcaaaaampcaabaaa
aaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdpjkjjjjea
egaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaap
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmneaekbfmneaekbfmnea
ekbfmneaaceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaahpcaabaaa
acaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaa
egaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
adaaaaaaaceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaaaaaaaaaa
diaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadiaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidmgfiiaidm
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaa
ehamfaljehamfaljehamfaljehamfaljegaobaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddoihiofmdpdiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaa
egaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdnbbaaaaak
bcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedmaknhcddnipmcpfln
kgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaaagiccaaaadaaaaaa
bcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaabaaaaaaaagaabaaa
aaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaa
aaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaa
agaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaa
afaaaaaakgiocaaaaaaaaaaaafaaaaaadiaaaaaiecaabaaaaaaaaaaabkaabaaa
abaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaaacaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaaacaaaaaaagadbaaaabaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaadgaaaaafmccabaaaacaaaaaa
kgaobaaaabaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaacaaaaaamgaabaaa
acaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaa
diaaaaaihccabaaaadaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabjaaaaaa
diaaaaaiecaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaa
aaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaai
iccabaaaadaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}

SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 160 // 112 used size, 11 vars
Vector 64 [_Color] 4
Vector 80 [unity_LightmapST] 4
Vector 96 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 0 [_Time] 4
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 416 used size, 8 vars
Vector 400 [unity_ShadowFadeCenterAndType] 4
ConstBuffer "UnityPerDraw" 336 // 320 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityShadows" 2
BindCB "UnityPerDraw" 3
// 52 instructions, 4 temp regs, 0 temp arrays:
// ALU 30 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_3
eefiecedjkddggofbhncileimamohmeieehgjlkgabaaaaaajaaoaaaaaeaaaaaa
daaaaaaadmafaaaacianaaaapaanaaaaebgpgodjaeafaaaaaeafaaaaaaacpopp
iiaeaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaaeaa
adaaabaaaaaaaaaaabaaaaaaabaaaeaaaaaaaaaaabaaafaaabaaafaaaaaaaaaa
acaabjaaabaaagaaaaaaaaaaadaaaaaaaiaaahaaaaaaaaaaadaaamaaafaaapaa
aaaaaaaaadaabcaaabaabeaaaaaaaaaaaaaaaaaaabacpoppfbaaaaafbfaaapka
kgjleednipmchfdnipmchfdokgjlmednfbaaaaafbgaaapkakgjlmedmaknhkddn
mnmmemdolfhocflofbaaaaafbhaaapkaaaaaaaeaaaaaiadpekbfmneanlapejma
fbaaaaafbiaaapkajkjjjjdpaaaaaaeamnmmmmdpjkjjjjeafbaaaaafbjaaapka
gfiiaidmehamfaljaaaaaadpaaaaaaaafbaaaaafbkaaapkaihiofmdoblmmlhdo
kpajjddoihiofmdpfbaaaaafblaaapkakgjlmedmaknhcddnipmcpflnkgjlmedn
fbaaaaafbmaaapkakgjlmedlaknhkddmaknhkdlmmnmmmmdnbpaaaaacafaaaaia
aaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjabpaaaaac
afaaafiaafaaapjaaeaaaaaeaaaaadoaadaaoejaadaaoekaadaaookaafaaaaad
aaaaapiaaaaakkjabgaajekaaeaaaaaeaaaaapiaaaaaaajabfaaoekaaaaaoeia
abaaaaacabaaadiabhaaoekaaeaaaaaeabaaabiaabaakkkaabaaaaibabaaffia
acaaaaadabaaabiaabaaaaiaafaakkjbafaaaaadabaaabiaabaaaaiaaeaaaaka
acaaaaadabaaamiaafaanejaabaanekaafaaaaadabaaabiaabaakkiaabaaaaia
afaaaaadabaaaeiaabaappiaadaaffjaaeaaaaaeaaaaapiaabaaaaiabiaaoeka
aaaaoeiabdaaaaacaaaaapiaaaaaoeiaaeaaaaaeaaaaapiaaaaaoeiabhaakkka
bhaappkaafaaaaadacaaapiaaaaaoeiaaaaaoeiaafaaaaadadaaapiaaaaaoeia
acaaoeiaaeaaaaaeaaaaapiaadaaoeiabgaappkaaaaaoeiaafaaaaadadaaapia
acaaoeiaadaaoeiaafaaaaadacaaapiaacaaoeiaadaaoeiaaeaaaaaeaaaaapia
adaaoeiabjaaaakaaaaaoeiaaeaaaaaeaaaaapiaacaaoeiabjaaffkaaaaaoeia
afaaaaadaaaaapiaabaakkiaaaaaoeiaafaaaaadaaaaapiaaaaaoeiabkaaoeka
afaaaaadaaaaapiaaaaaoeiaaaaaoeiaafaaaaadaaaaapiaaaaaoeiaaaaaoeia
ajaaaaadabaaabiaaaaaoeiabmaaoekaajaaaaadaaaaabiaaaaaoeiablaaoeka
afaaaaadaaaaagiaabaaaaiabeaaoakaaeaaaaaeaaaaadiabdaaoikaaaaaaaia
aaaaojiaacaaaaadaaaaadiaaaaaoeibaaaaoijaafaaaaadacaaapiaaaaaffja
aiaaoekaaeaaaaaeacaaapiaahaaoekaaaaaaaiaacaaoeiaaeaaaaaeacaaapia
ajaaoekaaaaaffiaacaaoeiaaeaaaaaeacaaapiaakaaoekaaaaappjaacaaoeia
afaaaaadaaaaaeiaacaaffiaafaaaakaafaaaaadabaaaiiaaaaakkiabjaakkka
afaaaaadabaaafiaacaapeiabjaakkkaacaaaaadabaaadoaabaakkiaabaaomia
aeaaaaaeaaaaamoaaeaabejaacaabekaacaalekaafaaaaadabaaaniaaaaaffja
baaajekaaeaaaaaeabaaaniaapaajekaaaaaaaiaabaaoeiaaeaaaaaeabaaania
bbaajekaaaaaffiaabaaoeiaaeaaaaaeabaaaniabcaajekaaaaappjaabaaoeia
acaaaaadabaaaniaabaaoeiaagaajekbafaaaaadacaaahoaabaapiiaagaappka
afaaaaadaaaaaeiaaaaaffjaamaakkkaaeaaaaaeaaaaabiaalaakkkaaaaaaaia
aaaakkiaaeaaaaaeaaaaabiaanaakkkaaaaaffiaaaaaaaiaaeaaaaaeaaaaabia
aoaakkkaaaaappjaaaaaaaiaacaaaaadaaaaaciaabaaffiaagaappkbafaaaaad
acaaaioaaaaaffiaaaaaaaibaeaaaaaeaaaaadmaacaappiaaaaaoekaacaaoeia
abaaaaacaaaaammaacaaoeiaabaaaaacabaaamoaacaaoeiappppaaaafdeieefc
oeahaaaaeaaaabaapjabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaae
egiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaadocbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaac
aeaaaaaadiaaaaakpcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedm
aknhkddnaknhkddnmnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaa
aceaaaaakgjleednipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaal
bcaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaea
abeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaia
ebaaaaaaafaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaa
abaaaaaaaaaaaaaaaaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaa
aaaaaaaaaeaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaa
dcaaaaampcaabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaea
mnmmmmdpjkjjjjeaegaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmnea
ekbfmneaekbfmneaekbfmneaaceaaaaanlapejmanlapejmanlapejmanlapejma
diaaaaahpcaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaah
pcaabaaaadaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaadaaaaaaaceaaaaalfhocflolfhocflolfhocflolfhocflo
egaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
adaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidm
gfiiaidmgfiiaidmegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
acaaaaaaaceaaaaaehamfaljehamfaljehamfaljehamfaljegaobaaaaaaaaaaa
diaaaaahpcaabaaaaaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaak
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddo
ihiofmdpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaak
bcaabaaaabaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlm
mnmmmmdnbbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedm
aknhcddnipmcpflnkgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaa
agiccaaaadaaaaaabcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaa
baaaaaaaagaabaaaaaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaa
egaabaiaebaaaaaaaaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaa
ogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaa
agiecaaaaaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaadiaaaaaiecaabaaa
aaaaaaaabkaabaaaabaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaa
acaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaaacaaaaaa
agadbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaadgaaaaaf
mccabaaaacaaaaaakgaobaaaabaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaa
acaaaaaamgaabaaaacaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
amaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaaoaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaa
acaaaaaabjaaaaaadiaaaaaihccabaaaadaaaaaaegacbaaaabaaaaaapgipcaaa
acaaaaaabjaaaaaadiaaaaaiecaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaa
akaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaagaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaa
aaaaiadpdiaaaaaiiccabaaaadaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaa
iaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
abaaaaaaamadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaa
imaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 13 [_Time]
Vector 14 [_ProjectionParams]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [_Color]
Vector 24 [_MainTex_ST]
"!!ARBvp1.0
# 59 ALU
PARAM c[32] = { { 2, 1, 6.4088488, 3.1415927 },
		state.matrix.mvp,
		program.local[5..24],
		{ 1.2, 2, 1.6, 4.8000002 },
		{ 0.048, 0.059999999, 0.23999999, 0.096000001 },
		{ 0.024, 0.079999998, 0.2, -0.00019840999 },
		{ 0.0083333002, -0.16161616, 0, 0.5 },
		{ 0.21538745, 0.35897908, 0.28718325, 0.86154979 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[0];
MAD R1.x, R0, -c[23].z, -vertex.color.z;
MUL R2.xyz, vertex.position.z, c[27];
ADD R1.x, R1, c[0].y;
MAD R0, vertex.position.x, c[26], R2.xyyz;
ADD R1.y, vertex.color, c[23];
MUL R1.x, R1, c[13];
MUL R1.x, R1, R1.y;
MAD R0, R1.x, c[25], R0;
FRC R0, R0;
MAD R0, R0, c[0].z, -c[0].w;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[28].y, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[28].x, R0;
MAD R0, R1, c[27].w, R0;
ADD R3.x, vertex.color.w, c[23].w;
MUL R2.x, vertex.texcoord[0].y, R3;
MUL R0, R0, R2.x;
MUL R0, R0, c[29];
MUL R0, R0, R0;
MUL R0, R0, R0;
DP4 R1.z, R0, c[30];
DP4 R1.x, R0, c[31];
MOV R1.y, c[28].z;
DP3 R0.y, R1, c[11];
DP3 R0.x, R1, c[9];
ADD R1.xz, vertex.position, -R0.xyyw;
MOV R1.yw, vertex.position;
DP4 R0.w, R1, c[4];
DP4 R0.z, R1, c[3];
DP4 R0.x, R1, c[1];
DP4 R0.y, R1, c[2];
MUL R2.xyz, R0.xyww, c[28].w;
MUL R1.xyz, vertex.normal, c[22].w;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
DP3 R2.w, R1, c[6];
MUL R2.y, R2, c[14].x;
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
ADD result.texcoord[1].xy, R2, R2.z;
DP4 R2.z, R0, c[17];
DP4 R2.y, R0, c[16];
DP4 R2.x, R0, c[15];
MUL R0.w, R2, R2;
MAD R0.w, R0.x, R0.x, -R0;
DP4 R0.z, R1, c[20];
DP4 R0.y, R1, c[19];
DP4 R0.x, R1, c[18];
MUL R1.xyz, R0.w, c[21];
ADD R0.xyz, R2, R0;
ADD result.texcoord[2].xyz, R0, R1;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
END
# 59 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_Time]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [_Color]
Vector 24 [_MainTex_ST]
"vs_2_0
; 61 ALU
def c25, 2.00000000, 1.00000000, 6.40884876, -3.14159274
def c26, 0.02400000, 0.08000000, 0.20000000, -0.16161616
def c27, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c28, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c29, 0.00833330, -0.00019841, 0.00000000, 0.50000000
def c30, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c31, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c32, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mov r0.x, c23.z
mad r1.x, c25, -r0, -v5.z
mul r2.xyz, v0.z, c26
add r1.x, r1, c25.y
mad r0, v0.x, c27, r2.xyyz
add r1.y, v5, c23
mul r1.x, r1, c12
mul r1.x, r1, r1.y
mad r0, r1.x, c28, r0
frc r0, r0
mad r0, r0, c25.z, c25.w
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c26.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c29.x, r0
mad r0, r1, c29.y, r0
add r3.x, v5.w, c23.w
mul r2.x, v3.y, r3
mul r0, r0, r2.x
mul r0, r0, c30
mul r0, r0, r0
mul r0, r0, r0
dp4 r1.z, r0, c31
dp4 r1.x, r0, c32
mov r1.y, c29.z
dp3 r0.y, r1, c10
dp3 r0.x, r1, c8
add r1.xz, v0, -r0.xyyw
mov r1.yw, v0
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r2.xyz, r0.xyww, c29.w
mul r1.xyz, v2, c22.w
mov oPos, r0
mov oT1.zw, r0
dp3 r2.w, r1, c5
mul r2.y, r2, c13.x
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c25.y
mad oT1.xy, r2.z, c14.zwzw, r2
dp4 r2.z, r0, c17
dp4 r2.y, r0, c16
dp4 r2.x, r0, c15
mul r0.w, r2, r2
mad r0.w, r0.x, r0.x, -r0
dp4 r0.z, r1, c20
dp4 r0.y, r1, c19
dp4 r0.x, r1, c18
mul r1.xyz, r0.w, c21
add r0.xyz, r2, r0
add oT2.xyz, r0, r1
mad oT0.xy, v3, c24, c24.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 128 // 96 used size, 9 vars
Vector 64 [_Color] 4
Vector 80 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 0 [_Time] 4
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 54 instructions, 4 temp regs, 0 temp arrays:
// ALU 34 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcbiimgdinfdfadbemakihciomoomjfnpabaaaaaageajaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oaahaaaaeaaaabaapiabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabjaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadocbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacaeaaaaaadiaaaaakpcaabaaa
aaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedmaknhkddnaknhkddnmnmmemdo
dcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaaaceaaaaakgjleednipmchfdn
ipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaackiacaia
ebaaaaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaiadpaaaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaafaaaaaadiaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaaaaaaaaai
gcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaaaaaaaaaaaeaaaaaadiaaaaah
bcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaa
abaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaadcaaaaampcaabaaaaaaaaaaa
agaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdpjkjjjjeaegaobaaa
aaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaappcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmneaekbfmneaekbfmneaekbfmnea
aceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaahpcaabaaaacaaaaaa
egaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaa
aaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaa
aceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaaaaaaaaaadiaaaaah
pcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaa
acaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidmgfiiaidmegaobaaa
aaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaaehamfalj
ehamfaljehamfaljehamfaljegaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
fgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddoihiofmdpdiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaaegaobaaa
aaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdnbbaaaaakbcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedmaknhcddnipmcpflnkgjlmedn
diaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaaagiccaaaadaaaaaabcaaaaaa
dcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaabaaaaaaaagaabaaaaaaaaaaa
jgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaa
igbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaai
bcaabaaaabaaaaaaegiocaaaacaaaaaabcaaaaaaegaobaaaaaaaaaaabbaaaaai
ccaabaaaabaaaaaaegiocaaaacaaaaaabdaaaaaaegaobaaaaaaaaaaabbaaaaai
ecaabaaaabaaaaaaegiocaaaacaaaaaabeaaaaaaegaobaaaaaaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaacaaaaaabfaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaacaaaaaabgaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaacaaaaaabhaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaacaaaaaabiaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
doaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 128 // 96 used size, 9 vars
Vector 64 [_Color] 4
Vector 80 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 0 [_Time] 4
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 54 instructions, 4 temp regs, 0 temp arrays:
// ALU 34 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_3
eefiecedkmjnlbhmanbgajgfndkkehfgifojhdpkabaaaaaakmaoaaaaaeaaaaaa
daaaaaaaheafaaaafmanaaaaceaoaaaaebgpgodjdmafaaaadmafaaaaaaacpopp
kiaeaaaajeaaaaaaajaaceaaaaaajaaaaaaajaaaaaaaceaaabaajaaaaaaaaeaa
acaaabaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaaabaaafaaabaaaeaaaaaaaaaa
acaabcaaahaaafaaaaaaaaaaadaaaaaaaeaaamaaaaaaaaaaadaaamaaadaabaaa
aaaaaaaaadaabaaaabaabdaaaaaaaaaaadaabcaaabaabeaaaaaaaaaaadaabeaa
abaabfaaaaaaaaaaaaaaaaaaabacpoppfbaaaaafbgaaapkakgjleednipmchfdn
ipmchfdokgjlmednfbaaaaafbhaaapkakgjlmedmaknhkddnmnmmemdolfhocflo
fbaaaaafbiaaapkaaaaaaaeaaaaaiadpekbfmneanlapejmafbaaaaafbjaaapka
jkjjjjdpaaaaaaeamnmmmmdpjkjjjjeafbaaaaafbkaaapkagfiiaidmehamfalj
aaaaaadpaaaaaaaafbaaaaafblaaapkaihiofmdoblmmlhdokpajjddoihiofmdp
fbaaaaafbmaaapkakgjlmedmaknhcddnipmcpflnkgjlmednfbaaaaafbnaaapka
kgjlmedlaknhkddmaknhkdlmmnmmmmdnbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaafiaafaaapja
aeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaafaaaaadaaaaapiaaaaakkja
bhaajekaaeaaaaaeaaaaapiaaaaaaajabgaaoekaaaaaoeiaabaaaaacabaaadia
biaaoekaaeaaaaaeabaaabiaabaakkkaabaaaaibabaaffiaacaaaaadabaaabia
abaaaaiaafaakkjbafaaaaadabaaabiaabaaaaiaadaaaakaacaaaaadabaaagia
afaapejaabaapekaafaaaaadabaaabiaabaaffiaabaaaaiaafaaaaadabaaacia
abaakkiaadaaffjaaeaaaaaeaaaaapiaabaaaaiabjaaoekaaaaaoeiabdaaaaac
aaaaapiaaaaaoeiaaeaaaaaeaaaaapiaaaaaoeiabiaakkkabiaappkaafaaaaad
acaaapiaaaaaoeiaaaaaoeiaafaaaaadadaaapiaaaaaoeiaacaaoeiaaeaaaaae
aaaaapiaadaaoeiabhaappkaaaaaoeiaafaaaaadadaaapiaacaaoeiaadaaoeia
afaaaaadacaaapiaacaaoeiaadaaoeiaaeaaaaaeaaaaapiaadaaoeiabkaaaaka
aaaaoeiaaeaaaaaeaaaaapiaacaaoeiabkaaffkaaaaaoeiaafaaaaadaaaaapia
abaaffiaaaaaoeiaafaaaaadaaaaapiaaaaaoeiablaaoekaafaaaaadaaaaapia
aaaaoeiaaaaaoeiaafaaaaadaaaaapiaaaaaoeiaaaaaoeiaajaaaaadabaaabia
aaaaoeiabnaaoekaajaaaaadaaaaabiaaaaaoeiabmaaoekaafaaaaadaaaaagia
abaaaaiabeaaoakaaeaaaaaeaaaaadiabdaaoikaaaaaaaiaaaaaojiaacaaaaad
aaaaadiaaaaaoeibaaaaoijaafaaaaadabaaapiaaaaaffjaanaaoekaaeaaaaae
abaaapiaamaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaapiaaoaaoekaaaaaffia
abaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaappjaaaaaoeiaafaaaaadabaaabia
aaaaffiaaeaaaakaafaaaaadabaaaiiaabaaaaiabkaakkkaafaaaaadabaaafia
aaaapeiabkaakkkaacaaaaadabaaadoaabaakkiaabaaomiaafaaaaadabaaahia
acaaoejabfaappkaafaaaaadacaaahiaabaaffiabbaaoekaaeaaaaaeabaaalia
baaakekaabaaaaiaacaakeiaaeaaaaaeabaaahiabcaaoekaabaakkiaabaapeia
abaaaaacabaaaiiabiaaffkaajaaaaadacaaabiaafaaoekaabaaoeiaajaaaaad
acaaaciaagaaoekaabaaoeiaajaaaaadacaaaeiaahaaoekaabaaoeiaafaaaaad
adaaapiaabaacjiaabaakeiaajaaaaadaeaaabiaaiaaoekaadaaoeiaajaaaaad
aeaaaciaajaaoekaadaaoeiaajaaaaadaeaaaeiaakaaoekaadaaoeiaacaaaaad
acaaahiaacaaoeiaaeaaoeiaafaaaaadabaaaciaabaaffiaabaaffiaaeaaaaae
abaaabiaabaaaaiaabaaaaiaabaaffibaeaaaaaeacaaahoaalaaoekaabaaaaia
acaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacabaaamoaaaaaoeiappppaaaafdeieefcoaahaaaaeaaaabaa
piabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabjaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaadocbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacaeaaaaaadiaaaaakpcaabaaaaaaaaaaakgbkbaaa
aaaaaaaaaceaaaaakgjlmedmaknhkddnaknhkddnmnmmemdodcaaaaampcaabaaa
aaaaaaaaagbabaaaaaaaaaaaaceaaaaakgjleednipmchfdnipmchfdokgjlmedn
egaobaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaa
aeaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaa
akaabaaaabaaaaaackbabaiaebaaaaaaafaaaaaadiaaaaaibcaabaaaabaaaaaa
akaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaaaaaaaaaigcaabaaaabaaaaaa
fgbhbaaaafaaaaaafgihcaaaaaaaaaaaaeaaaaaadiaaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaackaabaaa
abaaaaaabkbabaaaadaaaaaadcaaaaampcaabaaaaaaaaaaaagaabaaaabaaaaaa
aceaaaaajkjjjjdpaaaaaaeamnmmmmdpjkjjjjeaegaobaaaaaaaaaaabkaaaaaf
pcaabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaappcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaekbfmneaekbfmneaekbfmneaekbfmneaaceaaaaanlapejma
nlapejmanlapejmanlapejmadiaaaaahpcaabaaaacaaaaaaegaobaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaaaaaaaaaegaobaaa
acaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaalfhocflo
lfhocflolfhocflolfhocfloegaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaa
aceaaaaagfiiaidmgfiiaidmgfiiaidmgfiiaidmegaobaaaaaaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaaehamfaljehamfaljehamfalj
ehamfaljegaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaafgafbaaaabaaaaaa
egaobaaaaaaaaaaadiaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
ihiofmdoblmmlhdokpajjddoihiofmdpdiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaaegaobaaaaaaaaaaaaceaaaaa
kgjlmedlaknhkddmaknhkdlmmnmmmmdnbbaaaaakbcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaakgjlmedmaknhcddnipmcpflnkgjlmedndiaaaaaigcaabaaa
aaaaaaaaagaabaaaabaaaaaaagiccaaaadaaaaaabcaaaaaadcaaaaakdcaabaaa
aaaaaaaaigiacaaaadaaaaaabaaaaaaaagaabaaaaaaaaaaajgafbaaaaaaaaaaa
aaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaaigbabaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
fgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
adaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaa
egiocaaaacaaaaaabcaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaa
egiocaaaacaaaaaabdaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaa
egiocaaaacaaaaaabeaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
acaaaaaabfaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
acaaaaaabgaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
acaaaaaabhaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaa
acaaaaaabiaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaoaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Vector 17 [_Time]
Vector 18 [_ProjectionParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Matrix 9 [_Object2World]
Matrix 13 [_World2Object]
Vector 20 [_Color]
Vector 21 [unity_LightmapST]
Vector 22 [_MainTex_ST]
"!!ARBvp1.0
# 50 ALU
PARAM c[30] = { { 2, 1, 6.4088488, 3.1415927 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..22],
		{ 1.2, 2, 1.6, 4.8000002 },
		{ 0.048, 0.059999999, 0.23999999, 0.096000001 },
		{ 0.024, 0.079999998, 0.2, -0.00019840999 },
		{ 0.0083333002, -0.16161616, 0, 0.5 },
		{ 0.21538745, 0.35897908, 0.28718325, 0.86154979 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R3.xy, c[0];
MAD R1.x, R3, -c[20].z, -vertex.color.z;
MUL R0.xyz, vertex.position.z, c[25];
ADD R1.x, R1, c[0].y;
ADD R1.y, vertex.color, c[20];
MUL R1.x, R1, c[17];
MUL R1.x, R1, R1.y;
MAD R0, vertex.position.x, c[24], R0.xyyz;
MAD R0, R1.x, c[23], R0;
FRC R0, R0;
MAD R0, R0, c[0].z, -c[0].w;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[26].y, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[26].x, R0;
MAD R0, R1, c[25].w, R0;
ADD R3.x, vertex.color.w, c[20].w;
MUL R2.x, vertex.texcoord[0].y, R3;
MUL R0, R0, R2.x;
MUL R0, R0, c[27];
MUL R0, R0, R0;
MUL R0, R0, R0;
DP4 R1.z, R0, c[28];
DP4 R1.x, R0, c[29];
MOV R1.y, c[26].z;
DP3 R0.y, R1, c[15];
DP3 R0.x, R1, c[13];
ADD R1.xz, vertex.position, -R0.xyyw;
MOV R1.yw, vertex.position;
DP4 R0.w, R1, c[8];
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
MUL R2.xyz, R0.xyww, c[26].w;
MOV result.position, R0;
MUL R2.y, R2, c[18].x;
ADD result.texcoord[1].xy, R2, R2.z;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
ADD R2.xyz, R2, -c[19];
ADD R0.y, R3, -c[19].w;
DP4 R0.x, R1, c[3];
MOV result.texcoord[1].zw, R0;
MUL result.texcoord[3].xyz, R2, c[19].w;
MUL result.texcoord[3].w, -R0.x, R0.y;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[21], c[21].zwzw;
END
# 50 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 16 [_Time]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Matrix 8 [_Object2World]
Matrix 12 [_World2Object]
Vector 20 [_Color]
Vector 21 [unity_LightmapST]
Vector 22 [_MainTex_ST]
"vs_2_0
; 53 ALU
def c23, 2.00000000, 0.02400000, 0.08000000, 0.20000000
def c24, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c25, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c26, 6.40884876, -3.14159274, -0.16161616, 0.00833330
def c27, -0.00019841, 0.00000000, 0.50000000, 1.00000000
def c28, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c29, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c30, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r0.x, c20.z
mad r1.x, c23, -r0, -v5.z
mul r2.xyz, v0.z, c23.yzww
add r1.x, r1, c27.w
mad r0, v0.x, c24, r2.xyyz
add r1.y, v5, c20
mul r1.x, r1, c16
mul r1.x, r1, r1.y
mad r0, r1.x, c25, r0
frc r0, r0
mad r0, r0, c26.x, c26.y
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c26.z, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c26.w, r0
mad r0, r1, c27.x, r0
add r3.x, v5.w, c20.w
mul r2.x, v3.y, r3
mul r0, r0, r2.x
mul r0, r0, c28
mul r0, r0, r0
mul r0, r0, r0
dp4 r1.z, r0, c29
dp4 r1.x, r0, c30
mov r1.y, c27
dp3 r0.y, r1, c14
dp3 r0.x, r1, c12
add r1.xz, v0, -r0.xyyw
mov r1.yw, v0
dp4 r0.w, r1, c7
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mul r2.xyz, r0.xyww, c27.z
mov oPos, r0
mul r2.y, r2, c17.x
mov oT1.zw, r0
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad oT1.xy, r2.z, c18.zwzw, r2
dp4 r0.z, r1, c10
add r2.xyz, r0, -c19
mov r0.x, c19.w
add r0.y, c27.w, -r0.x
dp4 r0.x, r1, c2
mul oT3.xyz, r2, c19.w
mul oT3.w, -r0.x, r0.y
mad oT0.xy, v3, c22, c22.zwzw
mad oT2.xy, v4, c21, c21.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 160 // 112 used size, 11 vars
Vector 64 [_Color] 4
Vector 80 [unity_LightmapST] 4
Vector 96 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 0 [_Time] 4
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 416 used size, 8 vars
Vector 400 [unity_ShadowFadeCenterAndType] 4
ConstBuffer "UnityPerDraw" 336 // 320 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityShadows" 2
BindCB "UnityPerDraw" 3
// 52 instructions, 4 temp regs, 0 temp arrays:
// ALU 30 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecednpcbgilnbppiopefmhoejfngcamemigfabaaaaaaiaajaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeahaaaaeaaaabaa
pjabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaa
bdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaafpaaaaadocbabaaaafaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacaeaaaaaadiaaaaak
pcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedmaknhkddnaknhkddn
mnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaaaceaaaaakgjleedn
ipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaiadp
aaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaafaaaaaa
diaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaa
aaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaaaaaaaaaaaeaaaaaa
diaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaadcaaaaampcaabaaa
aaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdpjkjjjjea
egaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaap
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmneaekbfmneaekbfmnea
ekbfmneaaceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaahpcaabaaa
acaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaa
egaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
adaaaaaaaceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaaaaaaaaaa
diaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadiaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidmgfiiaidm
egaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaa
ehamfaljehamfaljehamfaljehamfaljegaobaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddoihiofmdpdiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaa
egaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdnbbaaaaak
bcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedmaknhcddnipmcpfln
kgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaaagiccaaaadaaaaaa
bcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaabaaaaaaaagaabaaa
aaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaa
aaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaa
agaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaa
afaaaaaakgiocaaaaaaaaaaaafaaaaaadiaaaaaiecaabaaaaaaaaaaabkaabaaa
abaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaaacaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaaacaaaaaaagadbaaaabaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaadgaaaaafmccabaaaacaaaaaa
kgaobaaaabaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaacaaaaaamgaabaaa
acaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaa
diaaaaaihccabaaaadaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabjaaaaaa
diaaaaaiecaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaa
aaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaai
iccabaaaadaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}

SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 160 // 112 used size, 11 vars
Vector 64 [_Color] 4
Vector 80 [unity_LightmapST] 4
Vector 96 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 0 [_Time] 4
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 416 used size, 8 vars
Vector 400 [unity_ShadowFadeCenterAndType] 4
ConstBuffer "UnityPerDraw" 336 // 320 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityShadows" 2
BindCB "UnityPerDraw" 3
// 52 instructions, 4 temp regs, 0 temp arrays:
// ALU 30 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_3
eefiecedjkddggofbhncileimamohmeieehgjlkgabaaaaaajaaoaaaaaeaaaaaa
daaaaaaadmafaaaacianaaaapaanaaaaebgpgodjaeafaaaaaeafaaaaaaacpopp
iiaeaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaaeaa
adaaabaaaaaaaaaaabaaaaaaabaaaeaaaaaaaaaaabaaafaaabaaafaaaaaaaaaa
acaabjaaabaaagaaaaaaaaaaadaaaaaaaiaaahaaaaaaaaaaadaaamaaafaaapaa
aaaaaaaaadaabcaaabaabeaaaaaaaaaaaaaaaaaaabacpoppfbaaaaafbfaaapka
kgjleednipmchfdnipmchfdokgjlmednfbaaaaafbgaaapkakgjlmedmaknhkddn
mnmmemdolfhocflofbaaaaafbhaaapkaaaaaaaeaaaaaiadpekbfmneanlapejma
fbaaaaafbiaaapkajkjjjjdpaaaaaaeamnmmmmdpjkjjjjeafbaaaaafbjaaapka
gfiiaidmehamfaljaaaaaadpaaaaaaaafbaaaaafbkaaapkaihiofmdoblmmlhdo
kpajjddoihiofmdpfbaaaaafblaaapkakgjlmedmaknhcddnipmcpflnkgjlmedn
fbaaaaafbmaaapkakgjlmedlaknhkddmaknhkdlmmnmmmmdnbpaaaaacafaaaaia
aaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjabpaaaaac
afaaafiaafaaapjaaeaaaaaeaaaaadoaadaaoejaadaaoekaadaaookaafaaaaad
aaaaapiaaaaakkjabgaajekaaeaaaaaeaaaaapiaaaaaaajabfaaoekaaaaaoeia
abaaaaacabaaadiabhaaoekaaeaaaaaeabaaabiaabaakkkaabaaaaibabaaffia
acaaaaadabaaabiaabaaaaiaafaakkjbafaaaaadabaaabiaabaaaaiaaeaaaaka
acaaaaadabaaamiaafaanejaabaanekaafaaaaadabaaabiaabaakkiaabaaaaia
afaaaaadabaaaeiaabaappiaadaaffjaaeaaaaaeaaaaapiaabaaaaiabiaaoeka
aaaaoeiabdaaaaacaaaaapiaaaaaoeiaaeaaaaaeaaaaapiaaaaaoeiabhaakkka
bhaappkaafaaaaadacaaapiaaaaaoeiaaaaaoeiaafaaaaadadaaapiaaaaaoeia
acaaoeiaaeaaaaaeaaaaapiaadaaoeiabgaappkaaaaaoeiaafaaaaadadaaapia
acaaoeiaadaaoeiaafaaaaadacaaapiaacaaoeiaadaaoeiaaeaaaaaeaaaaapia
adaaoeiabjaaaakaaaaaoeiaaeaaaaaeaaaaapiaacaaoeiabjaaffkaaaaaoeia
afaaaaadaaaaapiaabaakkiaaaaaoeiaafaaaaadaaaaapiaaaaaoeiabkaaoeka
afaaaaadaaaaapiaaaaaoeiaaaaaoeiaafaaaaadaaaaapiaaaaaoeiaaaaaoeia
ajaaaaadabaaabiaaaaaoeiabmaaoekaajaaaaadaaaaabiaaaaaoeiablaaoeka
afaaaaadaaaaagiaabaaaaiabeaaoakaaeaaaaaeaaaaadiabdaaoikaaaaaaaia
aaaaojiaacaaaaadaaaaadiaaaaaoeibaaaaoijaafaaaaadacaaapiaaaaaffja
aiaaoekaaeaaaaaeacaaapiaahaaoekaaaaaaaiaacaaoeiaaeaaaaaeacaaapia
ajaaoekaaaaaffiaacaaoeiaaeaaaaaeacaaapiaakaaoekaaaaappjaacaaoeia
afaaaaadaaaaaeiaacaaffiaafaaaakaafaaaaadabaaaiiaaaaakkiabjaakkka
afaaaaadabaaafiaacaapeiabjaakkkaacaaaaadabaaadoaabaakkiaabaaomia
aeaaaaaeaaaaamoaaeaabejaacaabekaacaalekaafaaaaadabaaaniaaaaaffja
baaajekaaeaaaaaeabaaaniaapaajekaaaaaaaiaabaaoeiaaeaaaaaeabaaania
bbaajekaaaaaffiaabaaoeiaaeaaaaaeabaaaniabcaajekaaaaappjaabaaoeia
acaaaaadabaaaniaabaaoeiaagaajekbafaaaaadacaaahoaabaapiiaagaappka
afaaaaadaaaaaeiaaaaaffjaamaakkkaaeaaaaaeaaaaabiaalaakkkaaaaaaaia
aaaakkiaaeaaaaaeaaaaabiaanaakkkaaaaaffiaaaaaaaiaaeaaaaaeaaaaabia
aoaakkkaaaaappjaaaaaaaiaacaaaaadaaaaaciaabaaffiaagaappkbafaaaaad
acaaaioaaaaaffiaaaaaaaibaeaaaaaeaaaaadmaacaappiaaaaaoekaacaaoeia
abaaaaacaaaaammaacaaoeiaabaaaaacabaaamoaacaaoeiappppaaaafdeieefc
oeahaaaaeaaaabaapjabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaae
egiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaadocbabaaaafaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaac
aeaaaaaadiaaaaakpcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedm
aknhkddnaknhkddnmnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaa
aceaaaaakgjleednipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaal
bcaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaea
abeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaia
ebaaaaaaafaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaa
abaaaaaaaaaaaaaaaaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaa
aaaaaaaaaeaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaa
dcaaaaampcaabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaea
mnmmmmdpjkjjjjeaegaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmnea
ekbfmneaekbfmneaekbfmneaaceaaaaanlapejmanlapejmanlapejmanlapejma
diaaaaahpcaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaah
pcaabaaaadaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaadaaaaaaaceaaaaalfhocflolfhocflolfhocflolfhocflo
egaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
adaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidm
gfiiaidmgfiiaidmegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
acaaaaaaaceaaaaaehamfaljehamfaljehamfaljehamfaljegaobaaaaaaaaaaa
diaaaaahpcaabaaaaaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaak
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddo
ihiofmdpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaak
bcaabaaaabaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlm
mnmmmmdnbbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedm
aknhcddnipmcpflnkgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaa
agiccaaaadaaaaaabcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaa
baaaaaaaagaabaaaaaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaa
egaabaiaebaaaaaaaaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaa
ogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaa
agiecaaaaaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaadiaaaaaiecaabaaa
aaaaaaaabkaabaaaabaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaa
acaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaaacaaaaaa
agadbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaadgaaaaaf
mccabaaaacaaaaaakgaobaaaabaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaa
acaaaaaamgaabaaaacaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
amaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaaoaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaa
acaaaaaabjaaaaaadiaaaaaihccabaaaadaaaaaaegacbaaaabaaaaaapgipcaaa
acaaaaaabjaaaaaadiaaaaaiecaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaa
akaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaagaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaa
aaaaiadpdiaaaaaiiccabaaaadaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaa
iaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
abaaaaaaamadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaa
imaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}

}
Program "fp" {
// Fragment combos: 4
//   opengl - ALU: 10 to 24, TEX: 2 to 4
//   d3d9 - ALU: 10 to 22, TEX: 3 to 5
//   d3d11 - ALU: 7 to 13, TEX: 2 to 4, FLOW: 1 to 1
//   d3d11_9x - ALU: 7 to 13, TEX: 2 to 4, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightBuffer] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 13 ALU, 2 TEX
PARAM c[3] = { state.lightmodel.ambient,
		program.local[1],
		{ 3 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R1.x, R0.w, c[1];
MOV R1.w, c[2].x;
MUL R2.xyz, R1.w, c[0];
MOV result.color.w, R0;
KIL -R1.x;
TXP R1.xyz, fragment.texcoord[1], texture[1], 2D;
LG2 R1.x, R1.x;
LG2 R1.z, R1.z;
LG2 R1.y, R1.y;
ADD R1.xyz, -R1, fragment.texcoord[2];
MAX R1.xyz, R1, R2;
MUL result.color.xyz, R0, R1;
END
# 13 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [glstate_lightmodel_ambient]
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightBuffer] 2D
"ps_2_0
; 13 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
def c2, 0.00000000, 1.00000000, 3.00000000, 0
dcl t0.xy
dcl t1
dcl t2.xyz
texld r1, t0, s0
add_pp r0.x, r1.w, -c1
cmp r0.x, r0, c2, c2.y
mov_pp r2, -r0.x
texldp r0, t1, s1
texkill r2.xyzw
mov r2.xyz, c0
log_pp r0.x, r0.x
log_pp r0.y, r0.y
log_pp r0.z, r0.z
mul r2.xyz, c2.z, r2
add_pp r0.xyz, -r0, t2
max_pp r0.xyz, r0, r2
mul_pp r0.xyz, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
ConstBuffer "$Globals" 128 // 116 used size, 9 vars
Float 112 [_Cutoff]
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerFrame" 1
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
// 13 instructions, 3 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedoomncelpagjpphcdmkdpafhfgjnbacilabaaaaaaoiacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcpiabaaaaeaaaaaaahoaaaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
lcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaa
akiacaiaebaaaaaaaaaaaaaaahaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaacpaaaaafhcaabaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaa
abaaaaaaegbcbaaaadaaaaaadiaaaaalhcaabaaaacaaaaaaegiccaaaabaaaaaa
aeaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadeaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
ConstBuffer "$Globals" 128 // 116 used size, 9 vars
Float 112 [_Cutoff]
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerFrame" 1
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
// 13 instructions, 3 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_3
eefiecedmgofjbkincooldbfipmolclhjidhmcbpabaaaaaageaeaaaaaeaaaaaa
daaaaaaakiabaaaakiadaaaadaaeaaaaebgpgodjhaabaaaahaabaaaaaaacpppp
cmabaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaahaaabaaaaaaaaaaaaaaabaaaeaaabaaabaaaaaaaaaaabacpppp
fbaaaaafacaaapkaaaaaeaeaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaadlabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaahlabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaadaaaacpiaaaaaoela
aaaioekaacaaaaadabaacpiaaaaappiaaaaaaakbagaaaaacacaaaiiaabaappla
afaaaaadacaaadiaacaappiaabaaoelaebaaaaababaaapiaecaaaaadabaacpia
acaaoeiaabaioekaapaaaaacacaacbiaabaaaaiaapaaaaacacaacciaabaaffia
apaaaaacacaaceiaabaakkiaacaaaaadabaachiaacaaoeibacaaoelaabaaaaac
acaaahiaabaaoekaafaaaaadacaachiaacaaoeiaacaaaakaalaaaaadadaachia
abaaoeiaacaaoeiaafaaaaadaaaachiaaaaaoeiaadaaoeiaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcpiabaaaaeaaaaaaahoaaaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
lcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaa
akiacaiaebaaaaaaaaaaaaaaahaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaacpaaaaafhcaabaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaa
abaaaaaaegbcbaaaadaaaaaadiaaaaalhcaabaaaacaaaaaaegiccaaaabaaaaaa
aeaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadeaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaa
heaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 1 [unity_LightmapFade]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightBuffer] 2D
SetTexture 2 [unity_Lightmap] 2D
SetTexture 3 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 24 ALU, 4 TEX
PARAM c[4] = { state.lightmodel.ambient,
		program.local[1..2],
		{ 8, 3 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TXP R3.xyz, fragment.texcoord[1], texture[1], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[2], texture[2], 2D;
SLT R1.x, R0.w, c[2];
MUL R2.xyz, R2.w, R2;
LG2 R3.x, R3.x;
LG2 R3.y, R3.y;
LG2 R3.z, R3.z;
MOV result.color.w, R0;
KIL -R1.x;
TEX R1, fragment.texcoord[2], texture[3], 2D;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[3].x;
DP4 R1.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R1.w, R1.w;
RCP R2.w, R1.w;
MAD R2.xyz, R2, c[3].x, -R1;
MAD_SAT R2.w, R2, c[1].z, c[1];
MAD R1.xyz, R2.w, R2, R1;
MOV R1.w, c[3].y;
MUL R2.xyz, R1.w, c[0];
ADD R1.xyz, -R3, R1;
MAX R1.xyz, R1, R2;
MUL result.color.xyz, R0, R1;
END
# 24 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [unity_LightmapFade]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightBuffer] 2D
SetTexture 2 [unity_Lightmap] 2D
SetTexture 3 [unity_LightmapInd] 2D
"ps_2_0
; 22 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.00000000, 1.00000000, 8.00000000, 3.00000000
dcl t0.xy
dcl t1
dcl t2.xy
dcl t3
texld r1, t0, s0
texldp r2, t1, s1
texld r3, t2, s2
add_pp r0.x, r1.w, -c2
cmp r0.x, r0, c3, c3.y
mov_pp r0, -r0.x
mul_pp r3.xyz, r3.w, r3
log_pp r2.x, r2.x
log_pp r2.y, r2.y
log_pp r2.z, r2.z
texkill r0.xyzw
texld r0, t2, s3
mul_pp r4.xyz, r0.w, r0
mul_pp r4.xyz, r4, c3.z
dp4 r0.x, t3, t3
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r3.xyz, r3, c3.z, -r4
mad_sat r0.x, r0, c1.z, c1.w
mad_pp r0.xyz, r0.x, r3, r4
mov r3.xyz, c0
mul r3.xyz, c3.w, r3
add_pp r0.xyz, -r2, r0
max_pp r0.xyz, r0, r3
mul_pp r0.xyz, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
ConstBuffer "$Globals" 160 // 148 used size, 11 vars
Vector 112 [unity_LightmapFade] 4
Float 144 [_Cutoff]
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerFrame" 1
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
// 23 instructions, 3 temp regs, 0 temp arrays:
// ALU 13 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedfphmofnapginnlfmecalcnecdbapiapnabaaaaaaiiaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefciaadaaaaeaaaaaaaoaaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadlcbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaia
ebaaaaaaaaaaaaaaajaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabbaaaaahbcaabaaaabaaaaaa
egbobaaaadaaaaaaegbobaaaadaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadccaaaalbcaabaaaabaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaa
ahaaaaaadkiacaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaa
abaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahccaabaaaabaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaabaaaaaaagajbaaa
acaaaaaafgafbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaacaaaaaapgapbaaaacaaaaaa
egacbaaaacaaaaaajgahbaiaebaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaajgahbaaaabaaaaaaaoaaaaahdcaabaaa
acaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaacpaaaaafhcaabaaa
acaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaalhcaabaaaacaaaaaaegiccaaaabaaaaaa
aeaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadeaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
ConstBuffer "$Globals" 160 // 148 used size, 11 vars
Vector 112 [unity_LightmapFade] 4
Float 144 [_Cutoff]
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerFrame" 1
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
// 23 instructions, 3 temp regs, 0 temp arrays:
// ALU 13 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_3
eefiecedgodecjginjaligpbkghimimpaobgjpjpabaaaaaapaagaaaaaeaaaaaa
daaaaaaajeacaaaabmagaaaalmagaaaaebgpgodjfmacaaaafmacaaaaaaacpppp
aeacaaaafiaaaaaaadaadeaaaaaafiaaaaaafiaaaeaaceaaaaaafiaaaaaaaaaa
abababaaacacacaaadadadaaaaaaahaaabaaaaaaaaaaaaaaaaaaajaaabaaabaa
aaaaaaaaabaaaeaaabaaacaaaaaaaaaaabacppppfbaaaaafadaaapkaaaaaaaeb
aaaaeaeaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapka
ecaaaaadaaaacpiaaaaaoelaaaaioekaacaaaaadabaacpiaaaaappiaabaaaakb
abaaaaacacaaadiaaaaaollaagaaaaacacaaaeiaabaapplaafaaaaadadaaadia
acaakkiaabaaoelaebaaaaababaaapiaecaaaaadabaacpiaadaaoeiaabaioeka
ajaaaaadabaaaiiaacaaoelaacaaoelaahaaaaacabaaaiiaabaappiaagaaaaac
abaaaiiaabaappiaaeaaaaaeabaabiiaabaappiaaaaakkkaaaaappkaecaaaaad
adaacpiaacaaoeiaacaioekaecaaaaadacaacpiaacaaoeiaadaioekaafaaaaad
acaaciiaacaappiaadaaaakaafaaaaadacaachiaacaaoeiaacaappiaafaaaaad
acaaciiaadaappiaadaaaakaaeaaaaaeadaaahiaacaappiaadaaoeiaacaaoeib
aeaaaaaeacaachiaabaappiaadaaoeiaacaaoeiaapaaaaacadaacbiaabaaaaia
apaaaaacadaacciaabaaffiaapaaaaacadaaceiaabaakkiaacaaaaadabaachia
acaaoeiaadaaoeibabaaaaacabaaaiiaadaaffkaafaaaaadacaachiaabaappia
acaaoekaalaaaaadadaachiaabaaoeiaacaaoeiaafaaaaadaaaachiaaaaaoeia
adaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefciaadaaaaeaaaaaaa
oaaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadmcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaadpcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaaj
bcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaajaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaabaaaaaabbaaaaahbcaabaaaabaaaaaaegbobaaaadaaaaaaegbobaaa
adaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadccaaaalbcaabaaa
abaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaaahaaaaaadkiacaaaaaaaaaaa
ahaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdiaaaaahocaabaaaabaaaaaaagajbaaaacaaaaaafgafbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaeb
dcaaaaakhcaabaaaacaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaajgahbaia
ebaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaajgahbaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaacaaaaaa
pgbpbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaacpaaaaafhcaabaaaacaaaaaaegacbaaaacaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaa
diaaaaalhcaabaaaacaaaaaaegiccaaaabaaaaaaaeaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaaaaadeaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaabaaaaaaamamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapalaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightBuffer] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 2 TEX
PARAM c[3] = { state.lightmodel.ambient,
		program.local[1],
		{ 3 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R1.x, R0.w, c[1];
MOV R1.w, c[2].x;
MUL R2.xyz, R1.w, c[0];
MOV result.color.w, R0;
KIL -R1.x;
TXP R1.xyz, fragment.texcoord[1], texture[1], 2D;
ADD R1.xyz, R1, fragment.texcoord[2];
MAX R1.xyz, R1, R2;
MUL result.color.xyz, R0, R1;
END
# 10 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [glstate_lightmodel_ambient]
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightBuffer] 2D
"ps_2_0
; 10 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
def c2, 0.00000000, 1.00000000, 3.00000000, 0
dcl t0.xy
dcl t1
dcl t2.xyz
texld r1, t0, s0
add_pp r0.x, r1.w, -c1
cmp r0.x, r0, c2, c2.y
mov_pp r0, -r0.x
mov r2.xyz, c0
mul r2.xyz, c2.z, r2
texkill r0.xyzw
texldp r0, t1, s1
add_pp r0.xyz, r0, t2
max_pp r0.xyz, r0, r2
mul_pp r0.xyz, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
ConstBuffer "$Globals" 128 // 116 used size, 9 vars
Float 112 [_Cutoff]
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerFrame" 1
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
// 12 instructions, 3 temp regs, 0 temp arrays:
// ALU 7 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedfjhmfocjbbefehadjbeboiamnfjaanbmabaaaaaanaacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcoaabaaaaeaaaaaaahiaaaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
lcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaa
akiacaiaebaaaaaaaaaaaaaaahaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegbcbaaaadaaaaaadiaaaaalhcaabaaaacaaaaaa
egiccaaaabaaaaaaaeaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaa
deaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
ConstBuffer "$Globals" 128 // 116 used size, 9 vars
Float 112 [_Cutoff]
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerFrame" 1
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
// 12 instructions, 3 temp regs, 0 temp arrays:
// ALU 7 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_3
eefiecedjfhjoakomfniiccllodjpnldfbpdllgoabaaaaaaciaeaaaaaeaaaaaa
daaaaaaaieabaaaagmadaaaapeadaaaaebgpgodjemabaaaaemabaaaaaaacpppp
aiabaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaahaaabaaaaaaaaaaaaaaabaaaeaaabaaabaaaaaaaaaaabacpppp
fbaaaaafacaaapkaaaaaeaeaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaadlabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaahlabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaadaaaacpiaaaaaoela
aaaioekaacaaaaadabaacpiaaaaappiaaaaaaakbagaaaaacacaaaiiaabaappla
afaaaaadacaaadiaacaappiaabaaoelaebaaaaababaaapiaecaaaaadabaacpia
acaaoeiaabaioekaacaaaaadabaachiaabaaoeiaacaaoelaabaaaaacacaaahia
abaaoekaafaaaaadacaachiaacaaoeiaacaaaakaalaaaaadadaachiaabaaoeia
acaaoeiaafaaaaadaaaachiaaaaaoeiaadaaoeiaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcoaabaaaaeaaaaaaahiaaaaaafjaaaaaeegiocaaaaaaaaaaa
aiaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaia
ebaaaaaaaaaaaaaaahaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegbcbaaaadaaaaaadiaaaaalhcaabaaaacaaaaaaegiccaaa
abaaaaaaaeaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadeaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 1 [unity_LightmapFade]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightBuffer] 2D
SetTexture 2 [unity_Lightmap] 2D
SetTexture 3 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 21 ALU, 4 TEX
PARAM c[4] = { state.lightmodel.ambient,
		program.local[1..2],
		{ 8, 3 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[2], texture[2], 2D;
TXP R3.xyz, fragment.texcoord[1], texture[1], 2D;
SLT R1.x, R0.w, c[2];
MUL R2.xyz, R2.w, R2;
MOV result.color.w, R0;
KIL -R1.x;
TEX R1, fragment.texcoord[2], texture[3], 2D;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[3].x;
DP4 R1.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R1.w, R1.w;
RCP R2.w, R1.w;
MAD R2.xyz, R2, c[3].x, -R1;
MAD_SAT R2.w, R2, c[1].z, c[1];
MAD R1.xyz, R2.w, R2, R1;
MOV R1.w, c[3].y;
MUL R2.xyz, R1.w, c[0];
ADD R1.xyz, R3, R1;
MAX R1.xyz, R1, R2;
MUL result.color.xyz, R0, R1;
END
# 21 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [unity_LightmapFade]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightBuffer] 2D
SetTexture 2 [unity_Lightmap] 2D
SetTexture 3 [unity_LightmapInd] 2D
"ps_2_0
; 19 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 0.00000000, 1.00000000, 8.00000000, 3.00000000
dcl t0.xy
dcl t1
dcl t2.xy
dcl t3
texld r1, t0, s0
texldp r2, t1, s1
texld r3, t2, s3
add_pp r0.x, r1.w, -c2
cmp r0.x, r0, c3, c3.y
mov_pp r0, -r0.x
mul_pp r3.xyz, r3.w, r3
mul_pp r3.xyz, r3, c3.z
texkill r0.xyzw
texld r0, t2, s2
mul_pp r4.xyz, r0.w, r0
dp4 r0.x, t3, t3
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r4.xyz, r4, c3.z, -r3
mad_sat r0.x, r0, c1.z, c1.w
mad_pp r0.xyz, r0.x, r4, r3
mov r3.xyz, c0
mul r3.xyz, c3.w, r3
add_pp r0.xyz, r2, r0
max_pp r0.xyz, r0, r3
mul_pp r0.xyz, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
ConstBuffer "$Globals" 160 // 148 used size, 11 vars
Vector 112 [unity_LightmapFade] 4
Float 144 [_Cutoff]
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerFrame" 1
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
// 22 instructions, 3 temp regs, 0 temp arrays:
// ALU 12 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedpciojhbhogolepeikhjogollohakihakabaaaaaahaaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcgiadaaaaeaaaaaaankaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadlcbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakiacaia
ebaaaaaaaaaaaaaaajaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabbaaaaahbcaabaaaabaaaaaa
egbobaaaadaaaaaaegbobaaaadaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadccaaaalbcaabaaaabaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaa
ahaaaaaadkiacaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaa
abaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahccaabaaaabaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaabaaaaaaagajbaaa
acaaaaaafgafbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaacaaaaaapgapbaaaacaaaaaa
egacbaaaacaaaaaajgahbaiaebaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaajgahbaaaabaaaaaaaoaaaaahdcaabaaa
acaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaalhcaabaaaacaaaaaa
egiccaaaabaaaaaaaeaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaa
deaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}

SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
ConstBuffer "$Globals" 160 // 148 used size, 11 vars
Vector 112 [unity_LightmapFade] 4
Float 144 [_Cutoff]
ConstBuffer "UnityPerFrame" 208 // 80 used size, 4 vars
Vector 64 [glstate_lightmodel_ambient] 4
BindCB "$Globals" 0
BindCB "UnityPerFrame" 1
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
// 22 instructions, 3 temp regs, 0 temp arrays:
// ALU 12 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_3
eefiecedjdjfceligmnbcaigbnpfhlhdgabmbpneabaaaaaaleagaaaaaeaaaaaa
daaaaaaahaacaaaaoaafaaaaiaagaaaaebgpgodjdiacaaaadiacaaaaaaacpppp
oaabaaaafiaaaaaaadaadeaaaaaafiaaaaaafiaaaeaaceaaaaaafiaaaaaaaaaa
abababaaacacacaaadadadaaaaaaahaaabaaaaaaaaaaaaaaaaaaajaaabaaabaa
aaaaaaaaabaaaeaaabaaacaaaaaaaaaaabacppppfbaaaaafadaaapkaaaaaaaeb
aaaaeaeaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapka
ecaaaaadaaaacpiaaaaaoelaaaaioekaacaaaaadabaacpiaaaaappiaabaaaakb
abaaaaacacaaadiaaaaaollaagaaaaacacaaaeiaabaapplaafaaaaadadaaadia
acaakkiaabaaoelaebaaaaababaaapiaecaaaaadabaacpiaadaaoeiaabaioeka
ajaaaaadabaaaiiaacaaoelaacaaoelaahaaaaacabaaaiiaabaappiaagaaaaac
abaaaiiaabaappiaaeaaaaaeabaabiiaabaappiaaaaakkkaaaaappkaecaaaaad
adaacpiaacaaoeiaacaioekaecaaaaadacaacpiaacaaoeiaadaioekaafaaaaad
acaaciiaacaappiaadaaaakaafaaaaadacaachiaacaaoeiaacaappiaafaaaaad
acaaciiaadaappiaadaaaakaaeaaaaaeadaaahiaacaappiaadaaoeiaacaaoeib
aeaaaaaeacaachiaabaappiaadaaoeiaacaaoeiaacaaaaadabaachiaabaaoeia
acaaoeiaabaaaaacabaaaiiaadaaffkaafaaaaadacaachiaabaappiaacaaoeka
alaaaaadadaachiaabaaoeiaacaaoeiaafaaaaadaaaachiaaaaaoeiaadaaoeia
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcgiadaaaaeaaaaaaankaaaaaa
fjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
mcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaajbcaabaaa
abaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaajaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaabbaaaaahbcaabaaaabaaaaaaegbobaaaadaaaaaaegbobaaaadaaaaaa
elaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadccaaaalbcaabaaaabaaaaaa
akaabaaaabaaaaaackiacaaaaaaaaaaaahaaaaaadkiacaaaaaaaaaaaahaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaeb
diaaaaahocaabaaaabaaaaaaagajbaaaacaaaaaafgafbaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
diaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdcaaaaak
hcaabaaaacaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaajgahbaiaebaaaaaa
abaaaaaadcaaaaajhcaabaaaabaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaa
jgahbaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaacaaaaaapgbpbaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaalhcaabaaaacaaaaaaegiccaaaabaaaaaaaeaaaaaaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadeaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
ejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaaamamaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapalaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

}
	}
	Pass {
		Name "ShadowCaster"
		Tags { "LightMode" = "ShadowCaster" }
		Fog {Mode Off}
		ZWrite On ZTest LEqual Cull Off
		Offset 1, 1
Program "vp" {
// Vertex combos: 2
//   opengl - ALU: 40 to 41
//   d3d9 - ALU: 42 to 44
//   d3d11 - ALU: 22 to 23, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 9 [_Time]
Vector 10 [unity_LightShadowBias]
Matrix 5 [_World2Object]
Vector 11 [_Color]
Vector 12 [_MainTex_ST]
"!!ARBvp1.0
# 41 ALU
PARAM c[20] = { { 2, 1, 6.4088488, 3.1415927 },
		state.matrix.mvp,
		program.local[5..12],
		{ 1.2, 2, 1.6, 4.8000002 },
		{ 0.048, 0.059999999, 0.23999999, 0.096000001 },
		{ 0.024, 0.079999998, 0.2, -0.00019840999 },
		{ 0.0083333002, -0.16161616, 0 },
		{ 0.21538745, 0.35897908, 0.28718325, 0.86154979 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[0];
MAD R1.x, R0, -c[11].z, -vertex.color.z;
MUL R2.xyz, vertex.position.z, c[15];
ADD R1.x, R1, c[0].y;
MAD R0, vertex.position.x, c[14], R2.xyyz;
ADD R1.y, vertex.color, c[11];
MUL R1.x, R1, c[9];
MUL R1.x, R1, R1.y;
MAD R0, R1.x, c[13], R0;
FRC R0, R0;
MAD R0, R0, c[0].z, -c[0].w;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[16].y, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[16].x, R0;
ADD R3.x, vertex.color.w, c[11].w;
MAD R0, R1, c[15].w, R0;
MUL R2.x, vertex.texcoord[0].y, R3;
MUL R0, R0, R2.x;
MUL R0, R0, c[17];
MUL R0, R0, R0;
MUL R1, R0, R0;
DP4 R0.z, R1, c[18];
DP4 R0.x, R1, c[19];
MOV R0.y, c[16].z;
DP3 R1.y, R0, c[7];
DP3 R1.x, R0, c[5];
ADD R0.xz, vertex.position, -R1.xyyw;
MOV R0.yw, vertex.position;
DP4 R1.y, R0, c[4];
DP4 R1.x, R0, c[3];
ADD R1.x, R1, c[10];
MAX R1.z, R1.x, -R1.y;
ADD R1.z, R1, -R1.x;
MAD result.position.z, R1, c[10].y, R1.x;
MOV result.position.w, R1.y;
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[12], c[12].zwzw;
END
# 41 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_Time]
Vector 9 [unity_LightShadowBias]
Matrix 4 [_World2Object]
Vector 10 [_Color]
Vector 11 [_MainTex_ST]
"vs_2_0
; 44 ALU
def c12, 2.00000000, 1.00000000, 6.40884876, -3.14159274
def c13, 0.02400000, 0.08000000, 0.20000000, -0.16161616
def c14, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c15, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c16, 0.00833330, -0.00019841, 0.00000000, 0
def c17, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c18, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c19, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_texcoord0 v3
dcl_color0 v5
mov r0.x, c10.z
mad r1.x, c12, -r0, -v5.z
mul r2.xyz, v0.z, c13
add r1.x, r1, c12.y
mad r0, v0.x, c14, r2.xyyz
add r1.y, v5, c10
mul r1.x, r1, c8
mul r1.x, r1, r1.y
mad r0, r1.x, c15, r0
frc r0, r0
mad r0, r0, c12.z, c12.w
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c13.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c16.x, r0
add r3.x, v5.w, c10.w
mad r0, r1, c16.y, r0
mul r2.x, v3.y, r3
mul r0, r0, r2.x
mul r0, r0, c17
mul r0, r0, r0
mul r1, r0, r0
dp4 r0.z, r1, c18
dp4 r0.x, r1, c19
mov r0.y, c16.z
dp3 r1.y, r0, c6
dp3 r1.x, r0, c4
add r0.xz, v0, -r1.xyyw
mov r0.yw, v0
dp4 r1.x, r0, c2
add r1.x, r1, c9
max r1.y, r1.x, c16.z
add r1.y, r1, -r1.x
mad r1.z, r1.y, c9.y, r1.x
dp4 r1.w, r0, c3
dp4 r1.x, r0, c0
dp4 r1.y, r0, c1
mov oPos, r1
mov oT0, r1
mad oT1.xy, v3, c11, c11.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 112 // 96 used size, 8 vars
Vector 64 [_Color] 4
Vector 80 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityShadows" 416 // 96 used size, 8 vars
Vector 80 [unity_LightShadowBias] 4
ConstBuffer "UnityPerDraw" 336 // 320 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 256 [_World2Object] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityShadows" 2
BindCB "UnityPerDraw" 3
// 38 instructions, 4 temp regs, 0 temp arrays:
// ALU 23 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedphipamlhlocnjnnhcmemlbagfakfmoglabaaaaaabeahaaaaadaaaaaa
cmaaaaaapeaaaaaaemabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcmaafaaaaeaaaabaahaabaaaafjaaaaae
egiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaae
egiocaaaacaaaaaaagaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaadocbabaaaafaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
aeaaaaaadiaaaaakpcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedm
aknhkddnaknhkddnmnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaa
aceaaaaakgjleednipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaal
bcaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaea
abeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaia
ebaaaaaaafaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaa
abaaaaaaaaaaaaaaaaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaa
aaaaaaaaaeaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaa
dcaaaaampcaabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaea
mnmmmmdpjkjjjjeaegaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmnea
ekbfmneaekbfmneaekbfmneaaceaaaaanlapejmanlapejmanlapejmanlapejma
diaaaaahpcaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaah
pcaabaaaadaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaa
aaaaaaaaegaobaaaadaaaaaaaceaaaaalfhocflolfhocflolfhocflolfhocflo
egaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaa
adaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaa
dcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidm
gfiiaidmgfiiaidmegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaa
acaaaaaaaceaaaaaehamfaljehamfaljehamfaljehamfaljegaobaaaaaaaaaaa
diaaaaahpcaabaaaaaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaak
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddo
ihiofmdpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaak
bcaabaaaabaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlm
mnmmmmdnbbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedm
aknhcddnipmcpflnkgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaa
agiccaaaadaaaaaabcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaa
baaaaaaaagaabaaaaaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaa
egaabaiaebaaaaaaaaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
akiacaaaacaaaaaaafaaaaaadgaaaaaflccabaaaaaaaaaaaegambaaaaaaaaaaa
deaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaai
bcaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
eccabaaaaaaaaaaabkiacaaaacaaaaaaafaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
afaaaaaaogikcaaaaaaaaaaaafaaaaaadoaaaaab"
}

SubProgram "opengl " {
Keywords { "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 13 [_Time]
Vector 14 [_LightPositionRange]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 15 [_Color]
Vector 16 [_MainTex_ST]
"!!ARBvp1.0
# 40 ALU
PARAM c[24] = { { 2, 1, 6.4088488, 3.1415927 },
		state.matrix.mvp,
		program.local[5..16],
		{ 1.2, 2, 1.6, 4.8000002 },
		{ 0.048, 0.059999999, 0.23999999, 0.096000001 },
		{ 0.024, 0.079999998, 0.2, -0.00019840999 },
		{ 0.0083333002, -0.16161616, 0 },
		{ 0.21538745, 0.35897908, 0.28718325, 0.86154979 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[0];
MAD R1.x, R0, -c[15].z, -vertex.color.z;
MUL R2.xyz, vertex.position.z, c[19];
ADD R1.x, R1, c[0].y;
MAD R0, vertex.position.x, c[18], R2.xyyz;
ADD R1.y, vertex.color, c[15];
MUL R1.x, R1, c[13];
MUL R1.x, R1, R1.y;
MAD R0, R1.x, c[17], R0;
FRC R0, R0;
MAD R0, R0, c[0].z, -c[0].w;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[20].y, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[20].x, R0;
ADD R3.x, vertex.color.w, c[15].w;
MAD R0, R1, c[19].w, R0;
MUL R2.x, vertex.texcoord[0].y, R3;
MUL R0, R0, R2.x;
MUL R0, R0, c[21];
MUL R0, R0, R0;
MUL R1, R0, R0;
DP4 R0.z, R1, c[22];
DP4 R0.x, R1, c[23];
MOV R0.y, c[20].z;
DP3 R1.y, R0, c[11];
DP3 R1.x, R0, c[9];
ADD R0.xz, vertex.position, -R1.xyyw;
MOV R0.yw, vertex.position;
DP4 R1.z, R0, c[7];
DP4 R1.x, R0, c[5];
DP4 R1.y, R0, c[6];
ADD result.texcoord[0].xyz, R1, -c[14];
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[16], c[16].zwzw;
END
# 40 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_Time]
Vector 13 [_LightPositionRange]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 14 [_Color]
Vector 15 [_MainTex_ST]
"vs_2_0
; 42 ALU
def c16, 2.00000000, 1.00000000, 6.40884876, -3.14159274
def c17, 0.02400000, 0.08000000, 0.20000000, -0.16161616
def c18, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c19, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c20, 0.00833330, -0.00019841, 0.00000000, 0
def c21, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c22, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c23, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_texcoord0 v3
dcl_color0 v5
mov r0.x, c14.z
mad r1.x, c16, -r0, -v5.z
mul r2.xyz, v0.z, c17
add r1.x, r1, c16.y
mad r0, v0.x, c18, r2.xyyz
add r1.y, v5, c14
mul r1.x, r1, c12
mul r1.x, r1, r1.y
mad r0, r1.x, c19, r0
frc r0, r0
mad r0, r0, c16.z, c16.w
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c17.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c20.x, r0
add r3.x, v5.w, c14.w
mad r0, r1, c20.y, r0
mul r2.x, v3.y, r3
mul r0, r0, r2.x
mul r0, r0, c21
mul r0, r0, r0
mul r1, r0, r0
dp4 r0.z, r1, c22
dp4 r0.x, r1, c23
mov r0.y, c20.z
dp3 r1.y, r0, c10
dp3 r1.x, r0, c8
add r0.xz, v0, -r1.xyyw
mov r0.yw, v0
dp4 r1.z, r0, c6
dp4 r1.x, r0, c4
dp4 r1.y, r0, c5
add oT0.xyz, r1, -c13
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
mad oT1.xy, v3, c15, c15.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 112 // 96 used size, 8 vars
Vector 64 [_Color] 4
Vector 80 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityLighting" 400 // 32 used size, 16 vars
Vector 16 [_LightPositionRange] 4
ConstBuffer "UnityPerDraw" 336 // 320 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 38 instructions, 4 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecednmogpgpkokmoikplcjggdkkjcenmcadkabaaaaaafmahaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcpaafaaaaeaaaabaahmabaaaafjaaaaaeegiocaaaaaaaaaaa
agaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
acaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaadocbabaaaafaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
giaaaaacaeaaaaaadiaaaaakpcaabaaaaaaaaaaakgbkbaaaaaaaaaaaaceaaaaa
kgjlmedmaknhkddnaknhkddnmnmmemdodcaaaaampcaabaaaaaaaaaaaagbabaaa
aaaaaaaaaceaaaaakgjleednipmchfdnipmchfdokgjlmednegaobaaaaaaaaaaa
dcaaaaalbcaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaabeaaaaa
aaaaaaeaabeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
ckbabaiaebaaaaaaafaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
akiacaaaabaaaaaaaaaaaaaaaaaaaaaigcaabaaaabaaaaaafgbhbaaaafaaaaaa
fgihcaaaaaaaaaaaaeaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkbabaaa
adaaaaaadcaaaaampcaabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaajkjjjjdp
aaaaaaeamnmmmmdpjkjjjjeaegaobaaaaaaaaaaabkaaaaafpcaabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaappcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
ekbfmneaekbfmneaekbfmneaekbfmneaaceaaaaanlapejmanlapejmanlapejma
nlapejmadiaaaaahpcaabaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaahpcaabaaaadaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaalfhocflolfhocflolfhocflo
lfhocfloegaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaadaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
adaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaagfiiaidm
gfiiaidmgfiiaidmgfiiaidmegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaacaaaaaaaceaaaaaehamfaljehamfaljehamfaljehamfaljegaobaaa
aaaaaaaadiaaaaahpcaabaaaaaaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaihiofmdoblmmlhdo
kpajjddoihiofmdpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaa
bbaaaaakbcaabaaaabaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedlaknhkddm
aknhkdlmmnmmmmdnbbaaaaakbcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
kgjlmedmaknhcddnipmcpflnkgjlmedndiaaaaaigcaabaaaaaaaaaaaagaabaaa
abaaaaaaagiccaaaadaaaaaabcaaaaaadcaaaaakdcaabaaaaaaaaaaaigiacaaa
adaaaaaabaaaaaaaagaabaaaaaaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaa
aaaaaaaaegaabaiaebaaaaaaaaaaaaaaigbabaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaadaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaacaaaaaafgafbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakncaabaaaaaaaaaaaagijcaaa
adaaaaaaamaaaaaaagaabaaaaaaaaaaaagajbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaaoaaaaaafgafbaaaaaaaaaaaigadbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhccabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaacaaaaaaabaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadoaaaaab"
}

}
Program "fp" {
// Fragment combos: 2
//   opengl - ALU: 4 to 10, TEX: 1 to 1
//   d3d9 - ALU: 7 to 13, TEX: 2 to 2
//   d3d11 - ALU: 2 to 7, TEX: 1 to 1, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "SHADOWS_DEPTH" }
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 4 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 0 } };
TEMP R0;
TEX R0.w, fragment.texcoord[1], texture[0], 2D;
SLT R0.x, R0.w, c[0];
MOV result.color, c[1].x;
KIL -R0.x;
END
# 4 instructions, 1 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SHADOWS_DEPTH" }
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 7 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 0, 0
dcl t0.xyzw
dcl t1.xy
texld r0, t1, s0
add_pp r0.x, r0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
rcp r0.x, t0.w
mul r0.x, t0.z, r0
mov_pp r0, r0.x
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "SHADOWS_DEPTH" }
ConstBuffer "$Globals" 112 // 100 used size, 8 vars
Float 96 [_Cutoff]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
// 6 instructions, 1 temp regs, 0 temp arrays:
// ALU 2 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedhaffnfphpdndfbkjjmbdngkpamjjjaniabaaaaaakiabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiaaaaaa
eaaaaaaadkaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaajbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaagaaaaaadbaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "opengl " {
Keywords { "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 1 TEX
PARAM c[4] = { program.local[0..1],
		{ 1, 255, 65025, 1.6058138e+08 },
		{ 0.0039215689 } };
TEMP R0;
TEX R0.w, fragment.texcoord[1], texture[0], 2D;
SLT R0.x, R0.w, c[1];
KIL -R0.x;
DP3 R0.x, fragment.texcoord[0], fragment.texcoord[0];
RSQ R0.x, R0.x;
RCP R0.x, R0.x;
MUL R0.x, R0, c[0].w;
MUL R0, R0.x, c[2];
FRC R0, R0;
MAD result.color, -R0.yzww, c[3].x, R0;
END
# 10 instructions, 1 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 13 ALU, 2 TEX
dcl_2d s0
def c2, 0.00000000, 1.00000000, 0.00392157, 0
def c3, 1.00000000, 255.00000000, 65025.00000000, 160581376.00000000
dcl t0.xyz
dcl t1.xy
texld r0, t1, s0
add_pp r0.x, r0.w, -c1
cmp r0.x, r0, c2, c2.y
mov_pp r0, -r0.x
texkill r0.xyzw
dp3 r0.x, t0, t0
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.x, r0, c0.w
mul r0, r0.x, c3
frc r1, r0
mov r0.z, -r1.w
mov r0.xyw, -r1.yzxw
mad r0, r0, c2.z, r1
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "SHADOWS_CUBE" }
ConstBuffer "$Globals" 112 // 100 used size, 8 vars
Float 96 [_Cutoff]
ConstBuffer "UnityLighting" 400 // 32 used size, 16 vars
Vector 16 [_LightPositionRange] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
SetTexture 0 [_MainTex] 2D 0
// 11 instructions, 1 temp regs, 0 temp arrays:
// ALU 7 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedplhjjiokobhfbdooofcokecjkiiljeioabaaaaaahmacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckeabaaaaeaaaaaaagjaaaaaa
fjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
akiacaiaebaaaaaaaaaaaaaaagaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaabaaaaaadiaaaaakpcaabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaahpedaaabhoehhacebjenbkaaaaafpcaabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaanpccabaaaaaaaaaaajgapbaiaebaaaaaaaaaaaaaaaceaaaaa
ibiaiadlibiaiadlibiaiadlibiaiadlegaobaaaaaaaaaaadoaaaaab"
}

}
	}
	Pass {
		Name "ShadowCollector"
		Tags { "LightMode" = "ShadowCollector" }
		Fog {Mode Off}
		ZWrite On ZTest LEqual
Program "vp" {
// Vertex combos: 4
//   opengl - ALU: 56 to 56
//   d3d9 - ALU: 58 to 58
//   d3d11 - ALU: 27 to 27, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 33 [_Time]
Matrix 9 [unity_World2Shadow0]
Matrix 13 [unity_World2Shadow1]
Matrix 17 [unity_World2Shadow2]
Matrix 21 [unity_World2Shadow3]
Matrix 25 [_Object2World]
Matrix 29 [_World2Object]
Vector 34 [_Color]
Vector 35 [_MainTex_ST]
"!!ARBvp1.0
# 56 ALU
PARAM c[43] = { { 2, 1, 6.4088488, 3.1415927 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..35],
		{ 1.2, 2, 1.6, 4.8000002 },
		{ 0.048, 0.059999999, 0.23999999, 0.096000001 },
		{ 0.024, 0.079999998, 0.2, -0.00019840999 },
		{ 0.0083333002, -0.16161616, 0 },
		{ 0.21538745, 0.35897908, 0.28718325, 0.86154979 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[0];
MAD R1.x, R0, -c[34].z, -vertex.color.z;
MUL R2.xyz, vertex.position.z, c[38];
ADD R1.x, R1, c[0].y;
MAD R0, vertex.position.x, c[37], R2.xyyz;
ADD R1.y, vertex.color, c[34];
MUL R1.x, R1, c[33];
MUL R1.x, R1, R1.y;
MAD R0, R1.x, c[36], R0;
FRC R0, R0;
MAD R0, R0, c[0].z, -c[0].w;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[39].y, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[39].x, R0;
MAD R0, R1, c[38].w, R0;
ADD R3.x, vertex.color.w, c[34].w;
MUL R2.x, vertex.texcoord[0].y, R3;
MUL R0, R0, R2.x;
MUL R0, R0, c[40];
MUL R0, R0, R0;
MUL R0, R0, R0;
MOV R2.yw, vertex.position;
DP4 R1.z, R0, c[41];
DP4 R1.x, R0, c[42];
MOV R1.y, c[39].z;
DP3 R0.y, R1, c[31];
DP3 R0.x, R1, c[29];
ADD R2.xz, vertex.position, -R0.xyyw;
DP4 R0.w, R2, c[3];
DP4 R1.w, R2, c[28];
DP4 R0.z, R2, c[27];
DP4 R0.x, R2, c[25];
DP4 R0.y, R2, c[26];
MOV R1.xyz, R0;
MOV R0.w, -R0;
DP4 result.texcoord[0].z, R1, c[11];
DP4 result.texcoord[0].y, R1, c[10];
DP4 result.texcoord[0].x, R1, c[9];
DP4 result.texcoord[1].z, R1, c[15];
DP4 result.texcoord[1].y, R1, c[14];
DP4 result.texcoord[1].x, R1, c[13];
DP4 result.texcoord[2].z, R1, c[19];
DP4 result.texcoord[2].y, R1, c[18];
DP4 result.texcoord[2].x, R1, c[17];
DP4 result.texcoord[3].z, R1, c[23];
DP4 result.texcoord[3].y, R1, c[22];
DP4 result.texcoord[3].x, R1, c[21];
MOV result.texcoord[4], R0;
DP4 result.position.w, R2, c[8];
DP4 result.position.z, R2, c[7];
DP4 result.position.y, R2, c[6];
DP4 result.position.x, R2, c[5];
MAD result.texcoord[5].xy, vertex.texcoord[0], c[35], c[35].zwzw;
END
# 56 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 32 [_Time]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [unity_World2Shadow1]
Matrix 16 [unity_World2Shadow2]
Matrix 20 [unity_World2Shadow3]
Matrix 24 [_Object2World]
Matrix 28 [_World2Object]
Vector 33 [_Color]
Vector 34 [_MainTex_ST]
"vs_2_0
; 58 ALU
def c35, 2.00000000, 1.00000000, 6.40884876, -3.14159274
def c36, 0.02400000, 0.08000000, 0.20000000, -0.16161616
def c37, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c38, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c39, 0.00833330, -0.00019841, 0.00000000, 0
def c40, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c41, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c42, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_texcoord0 v3
dcl_color0 v5
mov r0.x, c33.z
mad r1.x, c35, -r0, -v5.z
mul r2.xyz, v0.z, c36
add r1.x, r1, c35.y
mad r0, v0.x, c37, r2.xyyz
add r1.y, v5, c33
mul r1.x, r1, c32
mul r1.x, r1, r1.y
mad r0, r1.x, c38, r0
frc r0, r0
mad r0, r0, c35.z, c35.w
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c36.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c39.x, r0
mad r0, r1, c39.y, r0
add r3.x, v5.w, c33.w
mul r2.x, v3.y, r3
mul r0, r0, r2.x
mul r0, r0, c40
mul r0, r0, r0
mul r0, r0, r0
mov r2.yw, v0
dp4 r1.z, r0, c41
dp4 r1.x, r0, c42
mov r1.y, c39.z
dp3 r0.y, r1, c30
dp3 r0.x, r1, c28
add r2.xz, v0, -r0.xyyw
dp4 r0.w, r2, c2
dp4 r1.w, r2, c27
dp4 r0.z, r2, c26
dp4 r0.x, r2, c24
dp4 r0.y, r2, c25
mov r1.xyz, r0
mov r0.w, -r0
dp4 oT0.z, r1, c10
dp4 oT0.y, r1, c9
dp4 oT0.x, r1, c8
dp4 oT1.z, r1, c14
dp4 oT1.y, r1, c13
dp4 oT1.x, r1, c12
dp4 oT2.z, r1, c18
dp4 oT2.y, r1, c17
dp4 oT2.x, r1, c16
dp4 oT3.z, r1, c22
dp4 oT3.y, r1, c21
dp4 oT3.x, r1, c20
mov oT4, r0
dp4 oPos.w, r2, c7
dp4 oPos.z, r2, c6
dp4 oPos.y, r2, c5
dp4 oPos.x, r2, c4
mad oT5.xy, v3, c34, c34.zwzw
"
}

SubProgram "d3d9 " {
Keywords { "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 32 [_Time]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [unity_World2Shadow1]
Matrix 16 [unity_World2Shadow2]
Matrix 20 [unity_World2Shadow3]
Matrix 24 [_Object2World]
Matrix 28 [_World2Object]
Vector 33 [_Color]
Vector 34 [_MainTex_ST]
"vs_2_0
; 58 ALU
def c35, 2.00000000, 1.00000000, 6.40884876, -3.14159274
def c36, 0.02400000, 0.08000000, 0.20000000, -0.16161616
def c37, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c38, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c39, 0.00833330, -0.00019841, 0.00000000, 0
def c40, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c41, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c42, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_texcoord0 v3
dcl_color0 v5
mov r0.x, c33.z
mad r1.x, c35, -r0, -v5.z
mul r2.xyz, v0.z, c36
add r1.x, r1, c35.y
mad r0, v0.x, c37, r2.xyyz
add r1.y, v5, c33
mul r1.x, r1, c32
mul r1.x, r1, r1.y
mad r0, r1.x, c38, r0
frc r0, r0
mad r0, r0, c35.z, c35.w
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c36.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c39.x, r0
mad r0, r1, c39.y, r0
add r3.x, v5.w, c33.w
mul r2.x, v3.y, r3
mul r0, r0, r2.x
mul r0, r0, c40
mul r0, r0, r0
mul r0, r0, r0
mov r2.yw, v0
dp4 r1.z, r0, c41
dp4 r1.x, r0, c42
mov r1.y, c39.z
dp3 r0.y, r1, c30
dp3 r0.x, r1, c28
add r2.xz, v0, -r0.xyyw
dp4 r0.w, r2, c2
dp4 r1.w, r2, c27
dp4 r0.z, r2, c26
dp4 r0.x, r2, c24
dp4 r0.y, r2, c25
mov r1.xyz, r0
mov r0.w, -r0
dp4 oT0.z, r1, c10
dp4 oT0.y, r1, c9
dp4 oT0.x, r1, c8
dp4 oT1.z, r1, c14
dp4 oT1.y, r1, c13
dp4 oT1.x, r1, c12
dp4 oT2.z, r1, c18
dp4 oT2.y, r1, c17
dp4 oT2.x, r1, c16
dp4 oT3.z, r1, c22
dp4 oT3.y, r1, c21
dp4 oT3.x, r1, c20
mov oT4, r0
dp4 oPos.w, r2, c7
dp4 oPos.z, r2, c6
dp4 oPos.y, r2, c5
dp4 oPos.x, r2, c4
mad oT5.xy, v3, c34, c34.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 112 // 96 used size, 8 vars
Vector 64 [_Color] 4
Vector 80 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityShadows" 416 // 384 used size, 8 vars
Matrix 128 [unity_World2Shadow0] 4
Matrix 192 [unity_World2Shadow1] 4
Matrix 256 [unity_World2Shadow2] 4
Matrix 320 [unity_World2Shadow3] 4
ConstBuffer "UnityPerDraw" 336 // 320 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityShadows" 2
BindCB "UnityPerDraw" 3
// 59 instructions, 4 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedpbaeapfmipohieoeckhjlfkkfeobbbdjabaaaaaaomakaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefccaajaaaaeaaaabaaeiacaaaafjaaaaaeegiocaaaaaaaaaaa
agaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
biaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaadocbabaaaafaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagfaaaaaddccabaaaagaaaaaagiaaaaacaeaaaaaadiaaaaakpcaabaaa
aaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedmaknhkddnaknhkddnmnmmemdo
dcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaaaceaaaaakgjleednipmchfdn
ipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaackiacaia
ebaaaaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaiadpaaaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaafaaaaaadiaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaaaaaaaaai
gcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaaaaaaaaaaaeaaaaaadiaaaaah
bcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaa
abaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaadcaaaaampcaabaaaaaaaaaaa
agaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdpjkjjjjeaegaobaaa
aaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaappcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmneaekbfmneaekbfmneaekbfmnea
aceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaahpcaabaaaacaaaaaa
egaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaa
aaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaa
aceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaaaaaaaaaadiaaaaah
pcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaa
acaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidmgfiiaidmegaobaaa
aaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaaehamfalj
ehamfaljehamfaljehamfaljegaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
fgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddoihiofmdpdiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaaegaobaaa
aaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdnbbaaaaakbcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedmaknhcddnipmcpflnkgjlmedn
diaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaaagiccaaaadaaaaaabcaaaaaa
dcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaabaaaaaaaagaabaaaaaaaaaaa
jgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaa
igbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaa
fgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaajaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaacaaaaaaaiaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaakaaaaaakgakbaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaacaaaaaaalaaaaaa
pgapbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaa
abaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
acaaaaaaamaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaapgapbaaaabaaaaaa
egacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
acaaaaaabbaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaabaaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
acaaaaaabcaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaacaaaaaabdaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaa
diaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaabfaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaabeaaaaaaagaabaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaabgaaaaaa
kgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaa
acaaaaaabhaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadgaaaaafhccabaaa
afaaaaaaegacbaaaabaaaaaadiaaaaaiecaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
aeaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaagaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaagiccabaaaafaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaal
dccabaaaagaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaa
aaaaaaaaafaaaaaadoaaaaab"
}

SubProgram "opengl " {
Keywords { "SHADOWS_NONATIVE" "SHADOWS_SPLIT_SPHERES" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 33 [_Time]
Matrix 9 [unity_World2Shadow0]
Matrix 13 [unity_World2Shadow1]
Matrix 17 [unity_World2Shadow2]
Matrix 21 [unity_World2Shadow3]
Matrix 25 [_Object2World]
Matrix 29 [_World2Object]
Vector 34 [_Color]
Vector 35 [_MainTex_ST]
"!!ARBvp1.0
# 56 ALU
PARAM c[43] = { { 2, 1, 6.4088488, 3.1415927 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..35],
		{ 1.2, 2, 1.6, 4.8000002 },
		{ 0.048, 0.059999999, 0.23999999, 0.096000001 },
		{ 0.024, 0.079999998, 0.2, -0.00019840999 },
		{ 0.0083333002, -0.16161616, 0 },
		{ 0.21538745, 0.35897908, 0.28718325, 0.86154979 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[0];
MAD R1.x, R0, -c[34].z, -vertex.color.z;
MUL R2.xyz, vertex.position.z, c[38];
ADD R1.x, R1, c[0].y;
MAD R0, vertex.position.x, c[37], R2.xyyz;
ADD R1.y, vertex.color, c[34];
MUL R1.x, R1, c[33];
MUL R1.x, R1, R1.y;
MAD R0, R1.x, c[36], R0;
FRC R0, R0;
MAD R0, R0, c[0].z, -c[0].w;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[39].y, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[39].x, R0;
MAD R0, R1, c[38].w, R0;
ADD R3.x, vertex.color.w, c[34].w;
MUL R2.x, vertex.texcoord[0].y, R3;
MUL R0, R0, R2.x;
MUL R0, R0, c[40];
MUL R0, R0, R0;
MUL R0, R0, R0;
MOV R2.yw, vertex.position;
DP4 R1.z, R0, c[41];
DP4 R1.x, R0, c[42];
MOV R1.y, c[39].z;
DP3 R0.y, R1, c[31];
DP3 R0.x, R1, c[29];
ADD R2.xz, vertex.position, -R0.xyyw;
DP4 R0.w, R2, c[3];
DP4 R1.w, R2, c[28];
DP4 R0.z, R2, c[27];
DP4 R0.x, R2, c[25];
DP4 R0.y, R2, c[26];
MOV R1.xyz, R0;
MOV R0.w, -R0;
DP4 result.texcoord[0].z, R1, c[11];
DP4 result.texcoord[0].y, R1, c[10];
DP4 result.texcoord[0].x, R1, c[9];
DP4 result.texcoord[1].z, R1, c[15];
DP4 result.texcoord[1].y, R1, c[14];
DP4 result.texcoord[1].x, R1, c[13];
DP4 result.texcoord[2].z, R1, c[19];
DP4 result.texcoord[2].y, R1, c[18];
DP4 result.texcoord[2].x, R1, c[17];
DP4 result.texcoord[3].z, R1, c[23];
DP4 result.texcoord[3].y, R1, c[22];
DP4 result.texcoord[3].x, R1, c[21];
MOV result.texcoord[4], R0;
DP4 result.position.w, R2, c[8];
DP4 result.position.z, R2, c[7];
DP4 result.position.y, R2, c[6];
DP4 result.position.x, R2, c[5];
MAD result.texcoord[5].xy, vertex.texcoord[0], c[35], c[35].zwzw;
END
# 56 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SHADOWS_NONATIVE" "SHADOWS_SPLIT_SPHERES" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 32 [_Time]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [unity_World2Shadow1]
Matrix 16 [unity_World2Shadow2]
Matrix 20 [unity_World2Shadow3]
Matrix 24 [_Object2World]
Matrix 28 [_World2Object]
Vector 33 [_Color]
Vector 34 [_MainTex_ST]
"vs_2_0
; 58 ALU
def c35, 2.00000000, 1.00000000, 6.40884876, -3.14159274
def c36, 0.02400000, 0.08000000, 0.20000000, -0.16161616
def c37, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c38, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c39, 0.00833330, -0.00019841, 0.00000000, 0
def c40, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c41, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c42, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_texcoord0 v3
dcl_color0 v5
mov r0.x, c33.z
mad r1.x, c35, -r0, -v5.z
mul r2.xyz, v0.z, c36
add r1.x, r1, c35.y
mad r0, v0.x, c37, r2.xyyz
add r1.y, v5, c33
mul r1.x, r1, c32
mul r1.x, r1, r1.y
mad r0, r1.x, c38, r0
frc r0, r0
mad r0, r0, c35.z, c35.w
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c36.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c39.x, r0
mad r0, r1, c39.y, r0
add r3.x, v5.w, c33.w
mul r2.x, v3.y, r3
mul r0, r0, r2.x
mul r0, r0, c40
mul r0, r0, r0
mul r0, r0, r0
mov r2.yw, v0
dp4 r1.z, r0, c41
dp4 r1.x, r0, c42
mov r1.y, c39.z
dp3 r0.y, r1, c30
dp3 r0.x, r1, c28
add r2.xz, v0, -r0.xyyw
dp4 r0.w, r2, c2
dp4 r1.w, r2, c27
dp4 r0.z, r2, c26
dp4 r0.x, r2, c24
dp4 r0.y, r2, c25
mov r1.xyz, r0
mov r0.w, -r0
dp4 oT0.z, r1, c10
dp4 oT0.y, r1, c9
dp4 oT0.x, r1, c8
dp4 oT1.z, r1, c14
dp4 oT1.y, r1, c13
dp4 oT1.x, r1, c12
dp4 oT2.z, r1, c18
dp4 oT2.y, r1, c17
dp4 oT2.x, r1, c16
dp4 oT3.z, r1, c22
dp4 oT3.y, r1, c21
dp4 oT3.x, r1, c20
mov oT4, r0
dp4 oPos.w, r2, c7
dp4 oPos.z, r2, c6
dp4 oPos.y, r2, c5
dp4 oPos.x, r2, c4
mad oT5.xy, v3, c34, c34.zwzw
"
}

SubProgram "d3d9 " {
Keywords { "SHADOWS_NATIVE" "SHADOWS_SPLIT_SPHERES" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 32 [_Time]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [unity_World2Shadow1]
Matrix 16 [unity_World2Shadow2]
Matrix 20 [unity_World2Shadow3]
Matrix 24 [_Object2World]
Matrix 28 [_World2Object]
Vector 33 [_Color]
Vector 34 [_MainTex_ST]
"vs_2_0
; 58 ALU
def c35, 2.00000000, 1.00000000, 6.40884876, -3.14159274
def c36, 0.02400000, 0.08000000, 0.20000000, -0.16161616
def c37, 0.04800000, 0.06000000, 0.23999999, 0.09600000
def c38, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c39, 0.00833330, -0.00019841, 0.00000000, 0
def c40, 0.21538745, 0.35897908, 0.28718325, 0.86154979
def c41, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c42, 0.02400000, 0.04000000, -0.12000000, 0.09600000
dcl_position0 v0
dcl_texcoord0 v3
dcl_color0 v5
mov r0.x, c33.z
mad r1.x, c35, -r0, -v5.z
mul r2.xyz, v0.z, c36
add r1.x, r1, c35.y
mad r0, v0.x, c37, r2.xyyz
add r1.y, v5, c33
mul r1.x, r1, c32
mul r1.x, r1, r1.y
mad r0, r1.x, c38, r0
frc r0, r0
mad r0, r0, c35.z, c35.w
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c36.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c39.x, r0
mad r0, r1, c39.y, r0
add r3.x, v5.w, c33.w
mul r2.x, v3.y, r3
mul r0, r0, r2.x
mul r0, r0, c40
mul r0, r0, r0
mul r0, r0, r0
mov r2.yw, v0
dp4 r1.z, r0, c41
dp4 r1.x, r0, c42
mov r1.y, c39.z
dp3 r0.y, r1, c30
dp3 r0.x, r1, c28
add r2.xz, v0, -r0.xyyw
dp4 r0.w, r2, c2
dp4 r1.w, r2, c27
dp4 r0.z, r2, c26
dp4 r0.x, r2, c24
dp4 r0.y, r2, c25
mov r1.xyz, r0
mov r0.w, -r0
dp4 oT0.z, r1, c10
dp4 oT0.y, r1, c9
dp4 oT0.x, r1, c8
dp4 oT1.z, r1, c14
dp4 oT1.y, r1, c13
dp4 oT1.x, r1, c12
dp4 oT2.z, r1, c18
dp4 oT2.y, r1, c17
dp4 oT2.x, r1, c16
dp4 oT3.z, r1, c22
dp4 oT3.y, r1, c21
dp4 oT3.x, r1, c20
mov oT4, r0
dp4 oPos.w, r2, c7
dp4 oPos.z, r2, c6
dp4 oPos.y, r2, c5
dp4 oPos.x, r2, c4
mad oT5.xy, v3, c34, c34.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "SHADOWS_NATIVE" "SHADOWS_SPLIT_SPHERES" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 112 // 96 used size, 8 vars
Vector 64 [_Color] 4
Vector 80 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityShadows" 416 // 384 used size, 8 vars
Matrix 128 [unity_World2Shadow0] 4
Matrix 192 [unity_World2Shadow1] 4
Matrix 256 [unity_World2Shadow2] 4
Matrix 320 [unity_World2Shadow3] 4
ConstBuffer "UnityPerDraw" 336 // 320 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityShadows" 2
BindCB "UnityPerDraw" 3
// 59 instructions, 4 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedpbaeapfmipohieoeckhjlfkkfeobbbdjabaaaaaaomakaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaoaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefccaajaaaaeaaaabaaeiacaaaafjaaaaaeegiocaaaaaaaaaaa
agaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
biaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaadocbabaaaafaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagfaaaaaddccabaaaagaaaaaagiaaaaacaeaaaaaadiaaaaakpcaabaaa
aaaaaaaakgbkbaaaaaaaaaaaaceaaaaakgjlmedmaknhkddnaknhkddnmnmmemdo
dcaaaaampcaabaaaaaaaaaaaagbabaaaaaaaaaaaaceaaaaakgjleednipmchfdn
ipmchfdokgjlmednegaobaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaackiacaia
ebaaaaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaiadpaaaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaafaaaaaadiaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaaaaaaaaai
gcaabaaaabaaaaaafgbhbaaaafaaaaaafgihcaaaaaaaaaaaaeaaaaaadiaaaaah
bcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaa
abaaaaaackaabaaaabaaaaaabkbabaaaadaaaaaadcaaaaampcaabaaaaaaaaaaa
agaabaaaabaaaaaaaceaaaaajkjjjjdpaaaaaaeamnmmmmdpjkjjjjeaegaobaaa
aaaaaaaabkaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaappcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaekbfmneaekbfmneaekbfmneaekbfmnea
aceaaaaanlapejmanlapejmanlapejmanlapejmadiaaaaahpcaabaaaacaaaaaa
egaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaa
aaaaaaaaegaobaaaacaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaa
aceaaaaalfhocflolfhocflolfhocflolfhocfloegaobaaaaaaaaaaadiaaaaah
pcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaa
acaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaadaaaaaaaceaaaaagfiiaidmgfiiaidmgfiiaidmgfiiaidmegaobaaa
aaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaaehamfalj
ehamfaljehamfaljehamfaljegaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
fgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaihiofmdoblmmlhdokpajjddoihiofmdpdiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaakbcaabaaaabaaaaaaegaobaaa
aaaaaaaaaceaaaaakgjlmedlaknhkddmaknhkdlmmnmmmmdnbbaaaaakbcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaakgjlmedmaknhcddnipmcpflnkgjlmedn
diaaaaaigcaabaaaaaaaaaaaagaabaaaabaaaaaaagiccaaaadaaaaaabcaaaaaa
dcaaaaakdcaabaaaaaaaaaaaigiacaaaadaaaaaabaaaaaaaagaabaaaaaaaaaaa
jgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaa
igbabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaacaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaadaaaaaaaoaaaaaa
fgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaajaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaacaaaaaaaiaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaakaaaaaakgakbaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaacaaaaaaalaaaaaa
pgapbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaa
abaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
acaaaaaaamaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaapgapbaaaabaaaaaa
egacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
acaaaaaabbaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaabaaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
acaaaaaabcaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaacaaaaaabdaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaa
diaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaabfaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaabeaaaaaaagaabaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaabgaaaaaa
kgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaa
acaaaaaabhaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadgaaaaafhccabaaa
afaaaaaaegacbaaaabaaaaaadiaaaaaiecaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
aeaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaagaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaagiccabaaaafaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaal
dccabaaaagaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaa
aaaaaaaaafaaaaaadoaaaaab"
}

}
Program "fp" {
// Fragment combos: 4
//   opengl - ALU: 24 to 35, TEX: 2 to 2
//   d3d9 - ALU: 27 to 40, TEX: 3 to 3
//   d3d11 - ALU: 12 to 22, TEX: 1 to 1, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "SHADOWS_NONATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [_LightSplitsNear]
Vector 2 [_LightSplitsFar]
Vector 3 [_LightShadowData]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 24 ALU, 2 TEX
PARAM c[6] = { program.local[0..4],
		{ 1, 255, 0.0039215689 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.w, fragment.texcoord[5], texture[0], 2D;
SLT R0.w, R0, c[4].x;
SLT R2, fragment.texcoord[4].w, c[2];
SGE R1, fragment.texcoord[4].w, c[1];
MUL R1, R1, R2;
MUL R0.xyz, R1.y, fragment.texcoord[1];
MAD R0.xyz, R1.x, fragment.texcoord[0], R0;
MAD R0.xyz, R1.z, fragment.texcoord[2], R0;
MAD R0.xyz, fragment.texcoord[3], R1.w, R0;
MAD_SAT R1.y, fragment.texcoord[4].w, c[3].z, c[3].w;
MOV result.color.y, c[5].x;
TEX R0.x, R0, texture[1], 2D;
KIL -R0.w;
ADD R0.z, R0.x, -R0;
MOV R0.x, c[5];
CMP R1.x, R0.z, c[3], R0;
MUL R0.y, -fragment.texcoord[4].w, c[0].w;
ADD R0.y, R0, c[5].x;
MUL R0.xy, R0.y, c[5];
FRC R0.zw, R0.xyxy;
MOV R0.y, R0.w;
MAD R0.x, -R0.w, c[5].z, R0.z;
ADD_SAT result.color.x, R1, R1.y;
MOV result.color.zw, R0.xyxy;
END
# 24 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SHADOWS_NONATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [_LightSplitsNear]
Vector 2 [_LightSplitsFar]
Vector 3 [_LightShadowData]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"ps_2_0
; 27 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
def c5, 0.00000000, 1.00000000, 255.00000000, 0.00392157
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4.xyzw
dcl t5.xy
texld r2, t5, s0
add r1, t4.w, -c2
add r0, t4.w, -c1
cmp r1, r1, c5.x, c5.y
cmp r0, r0, c5.y, c5.x
mul r0, r0, r1
mul r1.xyz, r0.y, t1
mad r1.xyz, r0.x, t0, r1
mad r1.xyz, r0.z, t2, r1
add_pp r0.x, r2.w, -c4
mad r2.xyz, t3, r0.w, r1
cmp r0.x, r0, c5, c5.y
mov_pp r1, -r0.x
texld r0, r2, s1
texkill r1.xyzw
mul r1.x, -t4.w, c0.w
mov r2.x, c3
add r0.x, r0, -r2.z
cmp r0.x, r0, c5.y, r2
add r1.x, r1, c5.y
mul r2.xy, r1.x, c5.yzxw
mad_sat r1.x, t4.w, c3.z, c3.w
frc r2.xy, r2
add_sat r0.x, r0, r1
mov r1.y, r2
mad r1.x, -r2.y, c5.w, r2
mov r0.w, r1.y
mov r0.z, r1.x
mov r0.y, c5
mov_pp oC0, r0
"
}

SubProgram "d3d9 " {
Keywords { "SHADOWS_NATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [_LightSplitsNear]
Vector 2 [_LightSplitsFar]
Vector 3 [_LightShadowData]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"ps_2_0
; 27 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
def c5, 0.00000000, 1.00000000, 255.00000000, 0.00392157
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4.xyzw
dcl t5.xy
texld r2, t5, s0
add r1, t4.w, -c2
add r0, t4.w, -c1
cmp r1, r1, c5.x, c5.y
cmp r0, r0, c5.y, c5.x
mul r0, r0, r1
mul r1.xyz, r0.y, t1
mad r1.xyz, r0.x, t0, r1
mad r1.xyz, r0.z, t2, r1
add_pp r0.x, r2.w, -c4
mad r2.xyz, t3, r0.w, r1
cmp r0.x, r0, c5, c5.y
mov_pp r1, -r0.x
texld r0, r2, s1
texkill r1.xyzw
mov r2.x, c3
add r2.x, c5.y, -r2
mul r1.x, -t4.w, c0.w
mad r0.x, r0, r2, c3
add r1.x, r1, c5.y
mul r2.xy, r1.x, c5.yzxw
mad_sat r1.x, t4.w, c3.z, c3.w
frc r2.xy, r2
add_sat r0.x, r0, r1
mov r1.y, r2
mad r1.x, -r2.y, c5.w, r2
mov r0.w, r1.y
mov r0.z, r1.x
mov r0.y, c5
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "SHADOWS_NATIVE" }
ConstBuffer "$Globals" 112 // 100 used size, 8 vars
Float 96 [_Cutoff]
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 400 used size, 8 vars
Vector 96 [_LightSplitsNear] 4
Vector 112 [_LightSplitsFar] 4
Vector 384 [_LightShadowData] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityShadows" 2
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
// 25 instructions, 2 temp regs, 0 temp arrays:
// ALU 10 float, 0 int, 2 uint
// TEX 1 (0 load, 1 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkhgiaddlkfogogoebbgacikjnblpflinabaaaaaaceafaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaiaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcomadaaaaeaaaaaaaplaaaaaa
fjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaabjaaaaaafkaiaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadicbabaaa
afaaaaaagcbaaaaddcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaagaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaaaaaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaia
ebaaaaaaaaaaaaaaagaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaabnaaaaaipcaabaaaaaaaaaaa
pgbpbaaaafaaaaaaegiocaaaacaaaaaaagaaaaaaabaaaaakpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdbaaaaai
pcaabaaaabaaaaaapgbpbaaaafaaaaaaegiocaaaacaaaaaaahaaaaaaabaaaaak
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaaj
hcaabaaaabaaaaaaegbcbaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegbcbaaaadaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaaeaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaehaaaaalbcaabaaaaaaaaaaaegaabaaaaaaaaaaaaghabaaa
abaaaaaaaagabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaa
akiacaiaebaaaaaaacaaaaaabiaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaacaaaaaabiaaaaaa
dccaaaalccaabaaaaaaaaaaadkbabaaaafaaaaaackiacaaaacaaaaaabiaaaaaa
dkiacaaaacaaaaaabiaaaaaaaacaaaahbccabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaadkbabaiaebaaaaaaafaaaaaa
dkiacaaaabaaaaaaafaaaaaaabeaaaaaaaaaiadpdiaaaaakdcaabaaaaaaaaaaa
agaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaahpedaaaaaaaaaaaaaaaabkaaaaaf
dcaabaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakeccabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaabeaaaaaibiaiadlakaabaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaabkaabaaaaaaaaaaadgaaaaafcccabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
}

SubProgram "opengl " {
Keywords { "SHADOWS_NONATIVE" "SHADOWS_SPLIT_SPHERES" }
Vector 0 [_ProjectionParams]
Vector 1 [unity_ShadowSplitSpheres0]
Vector 2 [unity_ShadowSplitSpheres1]
Vector 3 [unity_ShadowSplitSpheres2]
Vector 4 [unity_ShadowSplitSpheres3]
Vector 5 [unity_ShadowSplitSqRadii]
Vector 6 [_LightShadowData]
Vector 7 [unity_ShadowFadeCenterAndType]
Float 8 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 35 ALU, 2 TEX
PARAM c[10] = { program.local[0..8],
		{ 1, 255, 0.0039215689 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.w, fragment.texcoord[5], texture[0], 2D;
ADD R1.xyz, fragment.texcoord[4], -c[1];
ADD R2.xyz, fragment.texcoord[4], -c[4];
SLT R0.w, R0, c[8].x;
DP3 R1.x, R1, R1;
ADD R0.xyz, fragment.texcoord[4], -c[2];
DP3 R1.y, R0, R0;
ADD R0.xyz, fragment.texcoord[4], -c[3];
DP3 R1.z, R0, R0;
DP3 R1.w, R2, R2;
SLT R2, R1, c[5];
ADD_SAT R0.xyz, R2.yzww, -R2;
MUL R1.xyz, R0.x, fragment.texcoord[1];
MAD R1.xyz, R2.x, fragment.texcoord[0], R1;
MAD R1.xyz, R0.y, fragment.texcoord[2], R1;
MAD R0.xyz, fragment.texcoord[3], R0.z, R1;
ADD R1.xyz, -fragment.texcoord[4], c[7];
MOV result.color.y, c[9].x;
TEX R0.x, R0, texture[1], 2D;
KIL -R0.w;
ADD R0.y, R0.x, -R0.z;
DP3 R0.z, R1, R1;
RSQ R0.z, R0.z;
MOV R0.x, c[9];
CMP R0.x, R0.y, c[6], R0;
MUL R0.y, -fragment.texcoord[4].w, c[0].w;
ADD R0.y, R0, c[9].x;
RCP R1.x, R0.z;
MUL R0.zw, R0.y, c[9].xyxy;
MAD_SAT R0.y, R1.x, c[6].z, c[6].w;
FRC R0.zw, R0;
ADD_SAT result.color.x, R0, R0.y;
MOV R0.y, R0.w;
MAD R0.x, -R0.w, c[9].z, R0.z;
MOV result.color.zw, R0.xyxy;
END
# 35 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SHADOWS_NONATIVE" "SHADOWS_SPLIT_SPHERES" }
Vector 0 [_ProjectionParams]
Vector 1 [unity_ShadowSplitSpheres0]
Vector 2 [unity_ShadowSplitSpheres1]
Vector 3 [unity_ShadowSplitSpheres2]
Vector 4 [unity_ShadowSplitSpheres3]
Vector 5 [unity_ShadowSplitSqRadii]
Vector 6 [_LightShadowData]
Vector 7 [unity_ShadowFadeCenterAndType]
Float 8 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"ps_2_0
; 40 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
def c9, 0.00000000, 1.00000000, 255.00000000, 0.00392157
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4
dcl t5.xy
texld r1, t5, s0
add r0.xyz, t4, -c1
add r2.xyz, t4, -c4
dp3 r0.x, r0, r0
add r1.xyz, t4, -c2
dp3 r0.y, r1, r1
add r1.xyz, t4, -c3
dp3 r0.z, r1, r1
dp3 r0.w, r2, r2
add r0, r0, -c5
cmp r0, r0, c9.x, c9.y
mov r1.x, r0.y
mov r1.z, r0.w
mov r1.y, r0.z
add_sat r1.xyz, r1, -r0
mul r2.xyz, r1.x, t1
mad r2.xyz, r0.x, t0, r2
add_pp r0.x, r1.w, -c8
mad r2.xyz, r1.y, t2, r2
mad r2.xyz, t3, r1.z, r2
cmp r0.x, r0, c9, c9.y
mov_pp r1, -r0.x
texld r0, r2, s1
texkill r1.xyzw
add r0.x, r0, -r2.z
mov r1.x, c6
add r2.xyz, -t4, c7
cmp r0.x, r0, c9.y, r1
dp3 r1.x, r2, r2
mul r2.x, -t4.w, c0.w
rsq r1.x, r1.x
add r2.x, r2, c9.y
rcp r1.x, r1.x
mad_sat r1.x, r1, c6.z, c6.w
mul r2.xy, r2.x, c9.yzxw
frc r2.xy, r2
add_sat r0.x, r0, r1
mov r1.y, r2
mad r1.x, -r2.y, c9.w, r2
mov r0.w, r1.y
mov r0.z, r1.x
mov r0.y, c9
mov_pp oC0, r0
"
}

SubProgram "d3d9 " {
Keywords { "SHADOWS_NATIVE" "SHADOWS_SPLIT_SPHERES" }
Vector 0 [_ProjectionParams]
Vector 1 [unity_ShadowSplitSpheres0]
Vector 2 [unity_ShadowSplitSpheres1]
Vector 3 [unity_ShadowSplitSpheres2]
Vector 4 [unity_ShadowSplitSpheres3]
Vector 5 [unity_ShadowSplitSqRadii]
Vector 6 [_LightShadowData]
Vector 7 [unity_ShadowFadeCenterAndType]
Float 8 [_Cutoff]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"ps_2_0
; 40 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
def c9, 0.00000000, 1.00000000, 255.00000000, 0.00392157
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4
dcl t5.xy
texld r1, t5, s0
add r0.xyz, t4, -c1
add r2.xyz, t4, -c4
dp3 r0.x, r0, r0
add r1.xyz, t4, -c2
dp3 r0.y, r1, r1
add r1.xyz, t4, -c3
dp3 r0.z, r1, r1
dp3 r0.w, r2, r2
add r0, r0, -c5
cmp r0, r0, c9.x, c9.y
mov r1.x, r0.y
mov r1.z, r0.w
mov r1.y, r0.z
add_sat r1.xyz, r1, -r0
mul r2.xyz, r1.x, t1
mad r2.xyz, r0.x, t0, r2
add_pp r0.x, r1.w, -c8
mad r2.xyz, r1.y, t2, r2
mad r2.xyz, t3, r1.z, r2
cmp r0.x, r0, c9, c9.y
mov_pp r1, -r0.x
texld r0, r2, s1
texkill r1.xyzw
mov r1.x, c6
add r1.x, c9.y, -r1
add r2.xyz, -t4, c7
mad r0.x, r0, r1, c6
dp3 r1.x, r2, r2
mul r2.x, -t4.w, c0.w
rsq r1.x, r1.x
add r2.x, r2, c9.y
rcp r1.x, r1.x
mad_sat r1.x, r1, c6.z, c6.w
mul r2.xy, r2.x, c9.yzxw
frc r2.xy, r2
add_sat r0.x, r0, r1
mov r1.y, r2
mad r1.x, -r2.y, c9.w, r2
mov r0.w, r1.y
mov r0.z, r1.x
mov r0.y, c9
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "SHADOWS_NATIVE" "SHADOWS_SPLIT_SPHERES" }
ConstBuffer "$Globals" 112 // 100 used size, 8 vars
Float 96 [_Cutoff]
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 416 used size, 8 vars
Vector 0 [unity_ShadowSplitSpheres0] 4
Vector 16 [unity_ShadowSplitSpheres1] 4
Vector 32 [unity_ShadowSplitSpheres2] 4
Vector 48 [unity_ShadowSplitSpheres3] 4
Vector 64 [unity_ShadowSplitSqRadii] 4
Vector 384 [_LightShadowData] 4
Vector 400 [unity_ShadowFadeCenterAndType] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityShadows" 2
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
// 36 instructions, 2 temp regs, 0 temp arrays:
// ALU 21 float, 0 int, 1 uint
// TEX 1 (0 load, 1 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedhmfhpfindjpoafhpafnddclppclmlpmbabaaaaaajeagaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfmafaaaaeaaaaaaafhabaaaa
fjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaabkaaaaaafkaiaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadpcbabaaa
afaaaaaagcbaaaaddcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaagaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaaaaaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaia
ebaaaaaaaaaaaaaaagaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egbcbaaaafaaaaaaegiccaiaebaaaaaaacaaaaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaaaafaaaaaaegiccaiaebaaaaaaacaaaaaaabaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaaaafaaaaaaegiccaiaebaaaaaaacaaaaaaacaaaaaabaaaaaahecaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaaaafaaaaaaegiccaiaebaaaaaaacaaaaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadbaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaacaaaaaaaeaaaaaadhaaaaaphcaabaaaabaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaaceaaaaa
aaaaaaiaaaaaaaiaaaaaaaiaaaaaaaaaabaaaaakpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaaaaaaahocaabaaa
aaaaaaaaagajbaaaabaaaaaafgaobaaaaaaaaaaadeaaaaakocaabaaaaaaaaaaa
fgaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaaegbcbaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegbcbaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegbcbaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaehaaaaalbcaabaaaaaaaaaaaegaabaaaaaaaaaaaaghabaaaabaaaaaa
aagabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaaakiacaia
ebaaaaaaacaaaaaabiaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaacaaaaaabiaaaaaaaaaaaaaj
ocaabaaaaaaaaaaaagbjbaaaafaaaaaaagijcaiaebaaaaaaacaaaaaabjaaaaaa
baaaaaahccaabaaaaaaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaelaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadccaaaalccaabaaaaaaaaaaabkaabaaa
aaaaaaaackiacaaaacaaaaaabiaaaaaadkiacaaaacaaaaaabiaaaaaaaacaaaah
bccabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaalbcaabaaa
aaaaaaaadkbabaiaebaaaaaaafaaaaaadkiacaaaabaaaaaaafaaaaaaabeaaaaa
aaaaiadpdiaaaaakdcaabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaahpedaaaaaaaaaaaaaaaabkaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
dcaaaaakeccabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaibiaiadl
akaabaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaaf
cccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}

}
	}

#LINE 166

}
//Fallback "Transparent/Cutout/VertexLit"
}
