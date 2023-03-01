Class {
	#name : #DruidJIT,
	#superclass : #StackToRegisterMappingCogit,
	#category : #'VMMaker-JIT'
}

{ #category : #'class initialization' }
DruidJIT class >> initializePrimitiveTable [

	<generated>
	MaxCompiledPrimitiveIndex := 10.
	primitiveTable := CArrayAccessor on:
		                  (Array new: MaxCompiledPrimitiveIndex + 1).
	self table: primitiveTable from: self primitiveTableArray
]

{ #category : #'class initialization' }
DruidJIT class >> primitiveTableArray [

	<generated>
	^ {
		  { 1. #gen_PrimitiveAdd. 1 }.
		  { 2. #gen_PrimitiveSubtract. 1 }.
		  { 3. #gen_PrimitiveLessThan. 1 }.
		  { 4. #gen_PrimitiveGreaterThan. 1 }.
		  { 5. #gen_PrimitiveLessOrEqual. 1 }.
		  { 6. #gen_PrimitiveGreaterOrEqual. 1 }.
		  { 7. #gen_PrimitiveEqual. 1 }.
		  { 8. #gen_PrimitiveNotEqual. 1 }.
		  { 9. #gen_PrimitiveMultiply. 1 }.
		  { 10. #gen_PrimitiveDivide. 1 } }
]

{ #category : #generated }
DruidJIT >> gen_PrimitiveAdd [
	"AutoGenerated by Druid"

	| jump1 jump2 currentBlock |
	self mclassIsSmallInteger ifFalse: [ ^ UnimplementedPrimitive ].
	self TstCq: 1 R: Arg0Reg.
	jump1 := self JumpZero: 0.
	self MoveR: Arg0Reg R: TempReg.
	self SubCq: 1 R: TempReg.
	self MoveR: ReceiverResultReg R: ClassReg.
	self AddR: ClassReg R: TempReg.
	jump2 := self JumpOverflow: 0.
	self MoveR: TempReg R: ReceiverResultReg.
	self genPrimReturn.
	currentBlock := self Label.
	jump1 jmpTarget: currentBlock.
	jump2 jmpTarget: currentBlock.
	^ CompletePrimitive
]

{ #category : #generated }
DruidJIT >> gen_PrimitiveDivide [
	"AutoGenerated by Druid"

	| jump5 jump3 jump1 currentBlock jump4 jump2 |
	self TstCq: 1 R: ReceiverResultReg.
	jump1 := self JumpZero: 0.
	self MoveR: ReceiverResultReg R: TempReg.
	self ArithmeticShiftRightCq: 3 R: TempReg.
	self TstCq: 1 R: Arg0Reg.
	jump2 := self JumpZero: 0.
	self MoveR: Arg0Reg R: ClassReg.
	self ArithmeticShiftRightCq: 3 R: ClassReg.
	self CmpCq: 0 R: ClassReg.
	jump3 := self JumpZero: 0.
	self
		DivR: ClassReg
		R: TempReg
		Quo: Extra0Reg
		Rem: SendNumArgsReg.
	self CmpCq: 0 R: SendNumArgsReg.
	jump4 := self JumpNonZero: 0.
	self
		DivR: ClassReg
		R: TempReg
		Quo: Extra0Reg
		Rem: SendNumArgsReg.
	self MoveR: Extra0Reg R: SendNumArgsReg.
	self ArithmeticShiftRightCq: 60 R: SendNumArgsReg.
	self AddCq: 1 R: SendNumArgsReg.
	self AndCq: 15 R: SendNumArgsReg.
	self CmpCq: 1 R: SendNumArgsReg.
	jump5 := self JumpGreater: 0.
	self MoveR: Extra0Reg R: SendNumArgsReg.
	self LogicalShiftLeftCq: 3 R: SendNumArgsReg.
	self AddCq: 1 R: SendNumArgsReg.
	self MoveR: SendNumArgsReg R: ReceiverResultReg.
	self genPrimReturn.
	currentBlock := self Label.
	jump1 jmpTarget: currentBlock.
	jump2 jmpTarget: currentBlock.
	jump3 jmpTarget: currentBlock.
	jump4 jmpTarget: currentBlock.
	jump5 jmpTarget: currentBlock.
	^ CompletePrimitive
]

{ #category : #generated }
DruidJIT >> gen_PrimitiveEqual [
	"AutoGenerated by Druid"

	| jump1 jump2 jump3 currentBlock |
	self MoveR: Arg0Reg R: TempReg.
	self MoveR: ReceiverResultReg R: ClassReg.
	self AndR: ClassReg R: TempReg.
	self TstCq: 1 R: TempReg.
	jump1 := self JumpZero: 0.
	self MoveR: ReceiverResultReg R: ClassReg.
	self CmpR: Arg0Reg R: ClassReg.
	jump2 := self JumpZero: 0.
	self MoveCq: objectMemory falseObject R: ReceiverResultReg.
	jump3 := self Jump: 0.
	currentBlock := self Label.
	jump2 jmpTarget: currentBlock.
	self MoveCq: objectMemory trueObject R: ReceiverResultReg.
	currentBlock := self Label.
	jump3 jmpTarget: currentBlock.
	self genPrimReturn.
	currentBlock := self Label.
	jump1 jmpTarget: currentBlock.
	^ CompletePrimitive
]

{ #category : #generated }
DruidJIT >> gen_PrimitiveGreaterOrEqual [
	"AutoGenerated by Druid"

	| jump1 jump2 jump3 currentBlock |
	self MoveR: Arg0Reg R: TempReg.
	self MoveR: ReceiverResultReg R: ClassReg.
	self AndR: ClassReg R: TempReg.
	self TstCq: 1 R: TempReg.
	jump1 := self JumpZero: 0.
	self MoveR: ReceiverResultReg R: ClassReg.
	self CmpR: Arg0Reg R: ClassReg.
	jump2 := self JumpGreaterOrEqual: 0.
	self MoveCq: objectMemory falseObject R: ReceiverResultReg.
	jump3 := self Jump: 0.
	currentBlock := self Label.
	jump2 jmpTarget: currentBlock.
	self MoveCq: objectMemory trueObject R: ReceiverResultReg.
	currentBlock := self Label.
	jump3 jmpTarget: currentBlock.
	self genPrimReturn.
	currentBlock := self Label.
	jump1 jmpTarget: currentBlock.
	^ CompletePrimitive
]

{ #category : #generated }
DruidJIT >> gen_PrimitiveGreaterThan [
	"AutoGenerated by Druid"

	| jump1 jump2 jump3 currentBlock |
	self MoveR: Arg0Reg R: TempReg.
	self MoveR: ReceiverResultReg R: ClassReg.
	self AndR: ClassReg R: TempReg.
	self TstCq: 1 R: TempReg.
	jump1 := self JumpZero: 0.
	self MoveR: ReceiverResultReg R: ClassReg.
	self CmpR: Arg0Reg R: ClassReg.
	jump2 := self JumpGreater: 0.
	self MoveCq: objectMemory falseObject R: ReceiverResultReg.
	jump3 := self Jump: 0.
	currentBlock := self Label.
	jump2 jmpTarget: currentBlock.
	self MoveCq: objectMemory trueObject R: ReceiverResultReg.
	currentBlock := self Label.
	jump3 jmpTarget: currentBlock.
	self genPrimReturn.
	currentBlock := self Label.
	jump1 jmpTarget: currentBlock.
	^ CompletePrimitive
]

{ #category : #generated }
DruidJIT >> gen_PrimitiveLessOrEqual [
	"AutoGenerated by Druid"

	| jump1 jump2 jump3 currentBlock |
	self MoveR: Arg0Reg R: TempReg.
	self MoveR: ReceiverResultReg R: ClassReg.
	self AndR: ClassReg R: TempReg.
	self TstCq: 1 R: TempReg.
	jump1 := self JumpZero: 0.
	self MoveR: ReceiverResultReg R: ClassReg.
	self CmpR: Arg0Reg R: ClassReg.
	jump2 := self JumpLessOrEqual: 0.
	self MoveCq: objectMemory falseObject R: ReceiverResultReg.
	jump3 := self Jump: 0.
	currentBlock := self Label.
	jump2 jmpTarget: currentBlock.
	self MoveCq: objectMemory trueObject R: ReceiverResultReg.
	currentBlock := self Label.
	jump3 jmpTarget: currentBlock.
	self genPrimReturn.
	currentBlock := self Label.
	jump1 jmpTarget: currentBlock.
	^ CompletePrimitive
]

{ #category : #generated }
DruidJIT >> gen_PrimitiveLessThan [
	"AutoGenerated by Druid"

	| jump1 jump2 jump3 currentBlock |
	self MoveR: Arg0Reg R: TempReg.
	self MoveR: ReceiverResultReg R: ClassReg.
	self AndR: ClassReg R: TempReg.
	self TstCq: 1 R: TempReg.
	jump1 := self JumpZero: 0.
	self MoveR: ReceiverResultReg R: ClassReg.
	self CmpR: Arg0Reg R: ClassReg.
	jump2 := self JumpLess: 0.
	self MoveCq: objectMemory falseObject R: ReceiverResultReg.
	jump3 := self Jump: 0.
	currentBlock := self Label.
	jump2 jmpTarget: currentBlock.
	self MoveCq: objectMemory trueObject R: ReceiverResultReg.
	currentBlock := self Label.
	jump3 jmpTarget: currentBlock.
	self genPrimReturn.
	currentBlock := self Label.
	jump1 jmpTarget: currentBlock.
	^ CompletePrimitive
]

{ #category : #generated }
DruidJIT >> gen_PrimitiveMultiply [
	"AutoGenerated by Druid"

	| jump1 jump2 jump3 currentBlock |
	self TstCq: 1 R: ReceiverResultReg.
	jump1 := self JumpZero: 0.
	self TstCq: 1 R: Arg0Reg.
	jump2 := self JumpZero: 0.
	self MoveR: ReceiverResultReg R: TempReg.
	self ArithmeticShiftRightCq: 3 R: TempReg.
	self MoveR: Arg0Reg R: ClassReg.
	self SubCq: 1 R: ClassReg.
	self MulR: ClassReg R: TempReg.
	jump3 := self JumpMultiplyOverflow: 0.
	self AddCq: 1 R: TempReg.
	self MoveR: TempReg R: ReceiverResultReg.
	self genPrimReturn.
	currentBlock := self Label.
	jump1 jmpTarget: currentBlock.
	jump2 jmpTarget: currentBlock.
	jump3 jmpTarget: currentBlock.
	^ CompletePrimitive
]

{ #category : #generated }
DruidJIT >> gen_PrimitiveNotEqual [
	"AutoGenerated by Druid"

	| jump1 jump2 jump3 currentBlock |
	self MoveR: Arg0Reg R: TempReg.
	self MoveR: ReceiverResultReg R: ClassReg.
	self AndR: ClassReg R: TempReg.
	self TstCq: 1 R: TempReg.
	jump1 := self JumpZero: 0.
	self MoveR: ReceiverResultReg R: ClassReg.
	self CmpR: Arg0Reg R: ClassReg.
	jump2 := self JumpNonZero: 0.
	self MoveCq: objectMemory falseObject R: ReceiverResultReg.
	jump3 := self Jump: 0.
	currentBlock := self Label.
	jump2 jmpTarget: currentBlock.
	self MoveCq: objectMemory trueObject R: ReceiverResultReg.
	currentBlock := self Label.
	jump3 jmpTarget: currentBlock.
	self genPrimReturn.
	currentBlock := self Label.
	jump1 jmpTarget: currentBlock.
	^ CompletePrimitive
]

{ #category : #generated }
DruidJIT >> gen_PrimitiveSubtract [
	"AutoGenerated by Druid"

	| jump1 jump2 jump3 currentBlock |
	self TstCq: 1 R: ReceiverResultReg.
	jump1 := self JumpZero: 0.
	self TstCq: 1 R: Arg0Reg.
	jump2 := self JumpZero: 0.
	self MoveR: Arg0Reg R: TempReg.
	self SubCq: 1 R: TempReg.
	self MoveR: ReceiverResultReg R: ClassReg.
	self SubR: TempReg R: ClassReg.
	jump3 := self JumpOverflow: 0.
	self MoveR: ClassReg R: ReceiverResultReg.
	self genPrimReturn.
	currentBlock := self Label.
	jump1 jmpTarget: currentBlock.
	jump2 jmpTarget: currentBlock.
	jump3 jmpTarget: currentBlock.
	^ CompletePrimitive
]