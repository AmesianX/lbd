; RUN: llc  -march=cpu0el -mcpu=cpu032I -relocation-model=pic -O3 < %s | FileCheck %s -check-prefix=16

@i = global i32 10, align 4
@j = global i32 20, align 4
@.str = private unnamed_addr constant [4 x i8] c"%i\0A\00", align 1

define i32 @main() nounwind {
entry:
  %0 = load i32, i32* @j, align 4
  %1 = load i32, i32* @i, align 4
  %sub = sub nsw i32 %0, %1
; 16:	subu	${{[0-9]+|t9}}, ${{[0-9]+|t9}}, ${{[0-9]+|t9}}
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i32 %sub)
  ret i32 0
}

declare i32 @printf(i8*, ...)
