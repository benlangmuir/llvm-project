; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV64I

declare void @callee(ptr, ptr)

define void @caller(i32 %n) {
; RV32I-LABEL: caller:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -64
; RV32I-NEXT:    .cfi_def_cfa_offset 64
; RV32I-NEXT:    sw ra, 60(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 56(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 52(sp) # 4-byte Folded Spill
; RV32I-NEXT:    .cfi_offset ra, -4
; RV32I-NEXT:    .cfi_offset s0, -8
; RV32I-NEXT:    .cfi_offset s1, -12
; RV32I-NEXT:    addi s0, sp, 64
; RV32I-NEXT:    .cfi_def_cfa s0, 0
; RV32I-NEXT:    andi sp, sp, -64
; RV32I-NEXT:    mv s1, sp
; RV32I-NEXT:    addi a0, a0, 15
; RV32I-NEXT:    andi a0, a0, -16
; RV32I-NEXT:    sub a0, sp, a0
; RV32I-NEXT:    mv sp, a0
; RV32I-NEXT:    mv a1, s1
; RV32I-NEXT:    call callee
; RV32I-NEXT:    addi sp, s0, -64
; RV32I-NEXT:    lw ra, 60(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 56(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 52(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 64
; RV32I-NEXT:    ret
;
; RV64I-LABEL: caller:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -64
; RV64I-NEXT:    .cfi_def_cfa_offset 64
; RV64I-NEXT:    sd ra, 56(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 48(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 40(sp) # 8-byte Folded Spill
; RV64I-NEXT:    .cfi_offset ra, -8
; RV64I-NEXT:    .cfi_offset s0, -16
; RV64I-NEXT:    .cfi_offset s1, -24
; RV64I-NEXT:    addi s0, sp, 64
; RV64I-NEXT:    .cfi_def_cfa s0, 0
; RV64I-NEXT:    andi sp, sp, -64
; RV64I-NEXT:    mv s1, sp
; RV64I-NEXT:    slli a0, a0, 32
; RV64I-NEXT:    srli a0, a0, 32
; RV64I-NEXT:    addi a0, a0, 15
; RV64I-NEXT:    andi a0, a0, -16
; RV64I-NEXT:    sub a0, sp, a0
; RV64I-NEXT:    mv sp, a0
; RV64I-NEXT:    mv a1, s1
; RV64I-NEXT:    call callee
; RV64I-NEXT:    addi sp, s0, -64
; RV64I-NEXT:    ld ra, 56(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 48(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s1, 40(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 64
; RV64I-NEXT:    ret
  %1 = alloca i8, i32 %n
  %2 = alloca i32, align 64
  call void @callee(ptr %1, ptr %2)
  ret void
}
