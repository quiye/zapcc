; RUN: llc -mtriple wasm32-unknown-unknown-wasm -filetype=obj %s -o - | obj2yaml | FileCheck %s

; Function that uses explict stack, and should generate a reference to
; __stack_pointer, along with the corresponding reloction entry.
define hidden void @foo() #0 {
entry:
  alloca i32, align 4
  ret void
}

; CHECK:  - Type:            IMPORT
; CHECK:     Imports:
; CHECK:       - Module:          env
; CHECK:         Field:           __stack_pointer
; CHECK:         Kind:            GLOBAL
; CHECK:         GlobalType:      I32
; CHECK:         GlobalMutable:   false
; CHECK:   - Type:            CODE
; CHECK:     Relocations:
; CHECK:       - Type:            R_WEBASSEMBLY_GLOBAL_INDEX_LEB
; CHECK:         Index:           0
