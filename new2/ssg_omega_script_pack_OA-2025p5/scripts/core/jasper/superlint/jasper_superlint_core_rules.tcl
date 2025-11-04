//////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       //
// These coded instructions, statements, and computer programs are the          //
// copyrighted works and confidential proprietary information of Cadence Design //
// Systems Inc. They may not be modified, copied, reproduced, distributed, or   //
// disclosed to third parties in any manner, medium, or form, in whole or in    //
// part, without the prior written consent of Cadence Design Systems Inc.       //
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////
// This file should not require any user modification	//
//////////////////////////////////////////////////////////

// Jasper Superlint rule file modified for the SSG Omega flow
// Tool version: 2025.03p001 (4/23/2025)
// Adapted from: <jasper_install>/etc/res/rtlds/rules/superlint.def
// Each category definition contains the name and description of checks that
// make up the body of the category.

domain LINT "List of categories in LINT domain"
{
  NAMING
  FILEFORMAT
  CODINGSTYLE
  SIM_SYNTH
  SYNTHESIS
  STRUCTURAL
  RACES
  BLACKBOX
}

domain DFT "List of categories in DFT domain"
{
  DFT_FUNCTIONAL
  INTEGRATION
  TEST_COVERAGE
}

domain AUTO_FORMAL "List of categories in AUTO_FORMAL domain"
{
  AUTO_FORMAL_OVERFLOW
  AUTO_FORMAL_BUS
  AUTO_FORMAL_IF_CASE
  AUTO_FORMAL_COMBO_LOOP
  AUTO_FORMAL_DEAD_CODE
  AUTO_FORMAL_FSM_DEADLOCK_LIVELOCK
  AUTO_FORMAL_FSM_REACHABILITY
  AUTO_FORMAL_OUT_OF_BOUND_INDEXING
  AUTO_FORMAL_SIGNALS
  AUTO_FORMAL_X_ASSIGNMENT
  AUTO_FORMAL_ASSERTION_CODING
  DESIGN_OPTIMIZATION
}

//*********************************************************************************
//** Following is the detail of the checks present in each category in SUPERLINT **
//*********************************************************************************

category NAMING "Naming convention rules"
{
  GEN_NF_NMCV {severity = warning} {msg = "The generate block '%s' in the design unit '%s' does not follow the recommended naming convention (rule pattern '%s')"}
  IDN_NF_ALCA {severity = warning} {msg = "Identifier '%s' contains characters or user specified keywords that are not allowed"}
  IDN_NF_FCNL {severity = warning} {msg = "First character of identifier '%s' is not a letter"}
  IDN_NR_ESCA {severity = warning} {msg = "Identifier '%s' contains escaped names, which should not be used"}
}

category FILEFORMAT "File format rules"
{
  FIL_MS_DUNM {severity = info}    {msg = "%s name '%s' differs from file name '%s'"}
  FIL_NO_CLMF {severity = warning} {msg = "`celldefine (file: '%s') and its corresponding `endcelldefine (file: '%s') are in different files"}
  FIL_NR_ABSP {severity = error}   {msg = "Absolute path is used to specify file '%s' in an `include statement"}
  FIL_NR_MMOD {severity = warning} {msg = "More than one design-unit definition in file '%s'"}
  FIL_NS_SUFX {severity = warning} {msg = "The file name '%s' is missing a valid HDL file name extension"}
}


category CODINGSTYLE "Coding style rules"
{
  ALW_NR_EMSL {severity = warning} {msg = "In module '%s', @* expands to an empty list and will never wake up"}
  ALW_NR_MCST {severity = warning} {msg = "In design-unit '%s', '%s' block has more than one construct"}
  ALW_NR_OPSL {severity = warning} {msg = "Operator other than 'or' or ',' used in sensitivity list '%s'"}
  ALW_NR_TRIL {severity = warning} {msg = "Tristate logic inferred in %s block"}
  ASG_NR_FNCP {severity = error}   {msg = "In module '%s', illegal %s port in function '%s' used in continuous assignment statement"}
  ASG_NR_EXPR {severity = error}   {msg = "In design unit '%s', assignment '%s' is found in the expression"}
  ASG_NR_EVNT {severity = error}   {msg = "In design-unit '%s', event control '%s' is used at the right-hand side of an assignment statement"}
  MOD_NR_STRN {severity = error}   {msg = "Signal strength '%s' found in the design-unit '%s'"}
  ARY_MS_DRNG {severity = warning} {msg = "Inconsistent ordering of bits in range declarations in design-unit %s -- should be all %s ranges"}
  ARY_NR_LOPR {severity = warning} {msg = "%s operator applied to multi-bit operand %s in design-unit %s"}
  ARY_NR_NERG {severity = warning} {msg = "Negative value '%s' used as an array range for '%s' in design-unit '%s'"}
  ARY_NR_PRMP {severity = warning} {msg = "Primitive input port (port index : %s) is connected to %s bits signal '%s'"}
  ARY_NR_SLRG {severity = info}    {msg = "The signal '%s', defined in %s '%s', is a one pin bus in its instance '%s'"}
  ASG_MS_RPAD {severity = warning} {msg = "Unequal length operands in assignment in design-unit/block '%s'. Length of RHS is less than LHS: LHS '%s' (%s) - %s bit(s), RHS '%s' (%s) - %s bit(s). RHS will be padded by %s bit(s)"}
  ASG_MS_RTRU {severity = warning} {msg = "Unequal length operands in assignment in design-unit/block '%s'. Length of RHS is greater than LHS: LHS '%s' (%s) - %s bit(s), RHS '%s' (%s) - %s bit(s). %s most significant bit(s) will be lost"}
  ASG_MS_VALR {severity = warning} {msg = "For the given assignment in VHDL design-unit/block '%s', value range of RHS '%s' cannot be accommodated in LHS range '%s'"}
  ASG_NR_POVF {severity = warning} {msg = "Potential overflow in assignment in design-unit/block '%s'. LHS '%s' (%s) is of %s bit(s), RHS '%s' (%s) can be of %s bit(s) %s"}
  ASG_NR_LMSB {severity = warning} {msg = "Truncation of bits in a constant '%s' in design-unit/block %s. The most significant bits are lost"}
  ASG_NR_MINP {severity = error}   {msg = "Assignment to a %s input port '%s' is not supported"}
  ASG_NR_NBFC {severity = warning} {msg = "Non-blocking assignment encountered in function '%s'"}
  ASG_NR_SOVF {severity = warning} {msg = "Overflow in assignment due to shift operation in design-unit '%s'. LHS '%s' (%s) is of %s bit(s) and RHS '%s' (%s) is of %s bit(s)"}
  ASG_NS_TRNB {severity = warning} {msg = "Truncation in constant conversion without a loss of bits in design-unit/block %s"}
  CST_NO_BASE {severity = warning} {msg = "Base type specification for constant '%s' is missing"}
  CAS_NO_CNST {severity = warning} {msg = "Case item expression '%s' is not a constant"}
  CAS_NO_DEFA {severity = warning} {msg = "Case statement with no default and selector '%s' is too wide to check if all cases are covered"}
  CAS_NO_DEND {severity = warning} {msg = "In design-unit '%s', the default clause of case statement with selector '%s' is not at the end"}
  CAS_NO_OTHR {severity = warning} {msg = "VHDL case statement with selector '%s' does not have an others clause"}
  CAS_NR_BRDT {severity = warning} {msg = "In design-unit '%s', casex/casez with select expression '%s' has bit '%s' redundant"}
  CAS_NR_CMUL {severity = warning} {msg = "Case item expression '%s' is covered more than once in design-unit %s"}
  CAS_NR_DEFN {severity = error}   {msg = "Case statement with selector '%s' in %s '%s' is incomplete, %s"}
  CAS_NR_DEFX {severity = warning} {msg = "Signal '%s' assigned in case statement is not assigned to X in default case"}
  CAS_NR_EXCS {severity = warning} {msg = "Case selector '%s' is an expression"}
  CAS_NR_FCDF {severity = warning} {msg = "In module %s, case with select expression '%s' having default statement, has redundant full_case pragma statement"}
  CAS_NR_OVCI {severity = warning} {msg = "Casex/Casez item expression '%s' overlapping with casex/casez item expression '%s' in design-unit %s"}
  CAS_NR_RDFX {severity = warning} {msg = "In design-unit '%s', case statement with selector '%s' is incomplete and assigned to x in default"}
  CAS_NR_UCIT {severity = warning} {msg = "Unequal length in case item comparison (selector is %d bits, case tag expression is %d bits) in design-unit %s"}
  CAS_NR_XCAZ {severity = error}   {msg = "Case item expression contains 'x' for a casez statement (useful only in casex statements) in design-unit %s"}
  CND_IR_CCAS {severity = warning} {msg = "Constant conditional expression '%s' encountered"}
  CND_NR_BWOP {severity = warning} {msg = "In module '%s', using a bit-wise operation in a conditional expression '%s' is not recommended"}
  CND_NR_DUPF {severity = warning} {msg = "In design unit '%s', a duplicate condition '%s' is found inside the '%s' statement"}
  CND_NR_EVXZ {severity = error}   {msg = "Conditional expression '%s' evaluates to 'x' or 'z'"}
  CND_NS_MBEX {severity = warning} {msg = "The expression '%s' in condition does not result in a single bit value in design-unit %s"}
  CST_MS_LPDZ {severity = warning} {msg = "Constant '%s' will be left-padded by %d '0' bits"}
  CST_MS_SIZE {severity = error}   {msg = "Constant '%s' has a value greater than its size"}
  CST_NO_DELY {severity = warning} {msg = "Delay %s in assignment is not a constant expression"}
  CST_NO_HIER {severity = error}   {msg = "Constant expression '%s' cannot contain a hierarchical identifier"}
  CST_NO_IVAL {severity = error}   {msg = "The initial value is missing in the declaration of constant '%s'"}
  CST_NR_REAL {severity = warning} {msg = "In design-unit '%s', real literal constant '%s' found"}
  DLY_NO_CSAG {severity = error}   {msg = "Delay used in VHDL conditional signal assignment to '%s'"}
  DLY_NR_NEGT {severity = error}   {msg = "Negative delay '%s' used in the statement"}
  DUT_NO_USED {severity = warning} {msg = "Design unit '%s' is not used"}
  EDG_NR_NEVT {severity = warning} {msg = "Named event '%s' triggered on an edge, which is not recommended"}
  EXP_NR_DIVZ {severity = error}   {msg = "Division by zero operation in expression '%s'"}
  EXP_NR_DVMD {severity = warning} {msg = "In design-unit '%s', '%s' expression used as operand in '%s' operator"}
  EXP_NR_ITYC {severity = warning} {msg = "Expression '%s' implicitly converted. LHS is '%s' vs RHS is '%s'"}
  EXP_NR_OVFB {severity = warning} {msg = "All bits are lost in shift operation '%s' in module/design-unit '%s'. '%d' bit data has been shifted by '%d'"}
  EXP_NR_MXSU {severity = warning} {msg = "Expression in design-unit '%s' has both signed '%s' and unsigned '%s' expressions"}
  EXP_NR_STUS {severity = warning} {msg = "Expression '%s' in design-unit '%s' is implicitly converted to type 'unsigned' from type 'signed'"}
  EXP_NR_TNST {severity = warning} {msg = "In design-unit '%s', nesting of ternary operation %s found at level %d"}
  EXP_NR_USTS {severity = warning} {msg = "Expression '%s' in design-unit '%s' is implicitly converted to type 'signed' from type 'unsigned'"}
  FIL_NR_MTMS {severity = warning} {msg = "Multiple timescales exist in the design. %s for module %s and %s for module %s"}
  FNC_MS_AFPR {severity = error}   {msg = "Width mismatch between formal '%s' of %s bit(s) and actual '%s' of %s bit(s) arguments of function/task '%s'"}
  FNC_MS_MTYP {severity = error}   {msg = "Task/function call argument '%s' is of incorrect type (formal %s versus actual %s)"}
  FNC_NO_AVAC {severity = warning} {msg = "Function '%s' is not assigned a value in some of the branches of conditional statement(s)"}
  FNC_NO_LRET {severity = warning} {msg = "Function '%s' in module/design-unit '%s' must have only one return statement, which should be the last statement in the function"}
  FNC_NO_UASG {severity = warning} {msg = "Function '%s' is not assigned a value or is partially assigned. '%s' is not assigned"}
  FNC_NR_AVGV {severity = warning} {msg = "Function '%s' in design-unit '%s' assigns a value to global variable '%s'"}
  FNC_NR_NARG {severity = warning} {msg = "Task/function/procedure '%s' call has wrong number of arguments"}
  FNC_NR_RETV {severity = warning} {msg = "In function '%s', the %s of return type and return value are not same"}
  FNC_NR_RLRT {severity = error}   {msg = "Function '%s' in design-unit '%s' has return of real datatype"}
  FNC_NR_UGLV {severity = error}   {msg = "Variable '%s' used in function '%s' of design-unit '%s' is outside of the function scope"}
  FNC_NR_SYSV {severity = error}   {msg = "System function/task '%s' is not allowed"}
  GEN_NO_GREP {severity = warning} {msg = "For-generate iterator %s does not reference the genvar '%s'"}
  GEN_NO_CONC {severity = warning} {msg = "In design-unit '%s', generate block does not contain conditional construct"}
  IDN_NR_AMKW {severity = warning} {msg = "AMS reserved word '%s' used as an identifier or label"}
  IDN_NR_CKYW {severity = warning} {msg = "C/C++ reserved word '%s' used as an identifier or label"}
  IDN_NR_DCSU {severity = warning} {msg = "In design-unit '%s', identifier name '%s' is used with case difference as '%s'"}
  IDN_NR_SVKW {severity = warning} {msg = "SystemVerilog reserved word '%s' used as an identifier or label"}
  IDN_NR_VHKW {severity = warning} {msg = "VHDL reserved word '%s' used as an identifier or label"}
  IDN_NR_VKYW {severity = warning} {msg = "Verilog reserved word '%s' used as an identifier or label"}
  IDX_MS_INDL {severity = error}   {msg = "VHDL port '%s' has index bounds mismatch between component declaration (%s) and entity declaration (%s)"}
  IDX_NO_CRCB {severity = warning} {msg = "Index range for array '%s' is unreachable inside conditional statement involving signal '%s'"}
  IDX_NR_DTTY {severity = error}   {msg = "Variable '%s' used as index in expression '%s' should be 2-state data type"}
  IFC_NO_FALW {severity = error}   {msg = "The 'if' statement specifying an asynchronous reset is not the first statement of the always block : '%s'"}
  IFC_NR_DGEL {severity = warning} {msg = "else/else-if statement of '%s' in %s '%s' is ambiguous"}
  INP_NO_LOAD {severity = warning} {msg = "Input/inout port '%s' declared in the design-unit '%s' has no load"}
  INP_NO_USED {severity = info}    {msg = "The input port '%s' declared in the %s '%s' is unused"}
  INP_NR_INIT {severity = warning} {msg = "In VHDL entity '%s', input port '%s' is initialized in declaration"}
  INP_UC_INST {severity = error}   {msg = "Input port '%s' of design-unit '%s' is being used inside design-unit, but not connected in its instance '%s'"}
  INP_NR_IOUT {severity = error}   {msg = "Top level input port '%s' is connected to inout port '%s' of lower hierarchy"}
  INP_NR_TSUP {severity = error}   {msg = "In design unit '%s' the input '%s' is tied to supply0/supply1"}
  INS_NR_CELD {severity = info}    {msg = "Instance '%s' of library cell '%s' is found in design-unit '%s'"}
  INS_NR_EXPR {severity = warning} {msg = "In design-unit '%s', formal port '%s' is connected to expression '%s'"}
  INS_MS_MTYP {severity = warning} {msg = "Port '%s' of instance '%s' has type mismatch (formal %s versus actual %s)"}
  INS_MS_PRMS {severity = error}   {msg = "Parameter '%s' has size mismatch between instantiation and declaration, '%s' bits at instantiation and '%s' bits at declaration"}
  INS_MS_PSIZ {severity = error}   {msg = "Port '%s' has size mismatch between design-unit instantiation and port declaration, '%s' bits at instantiation and '%s' bits at declaration"}
  INS_NO_INAM {severity = error}   {msg = "Instantiation of %s '%s' should have an instance name"}
  INS_NR_PODL {severity = warning} {msg = "Port connections for instance '%s' of %s '%s' should be made by name rather than by positional ordered list"}
  INS_NR_PRMP {severity = warning} {msg = "In design-unit '%s', parameter is used in actual expression '%s' of port '%s' in instance '%s'" }
  INS_NR_MPRM {severity = error}   {msg = "Too many parameters are present in %s instance: '%s'"}
  INS_NR_MPRT {severity = error}   {msg = "In module '%s', too many ports for module instance '%s'"}
  INS_NR_PTEX {severity = error}   {msg = "%s is used in a port expression"}
  INT_NR_OVFL {severity = error}   {msg = "%s exceeds the range of a 32-bit signed integer, using %d instead"}
  INT_NR_PSBT {severity = error}   {msg = "Bit/part select of %s variable '%s' encountered"}
  IOP_NO_USED {severity = warning} {msg = "The inout port '%s' declared in the %s '%s' is unused (neither read nor assigned)"}
  IOP_NR_UASG {severity = warning} {msg = "The inout port '%s' declared in the %s '%s' is unassigned, but read"}
  IOP_NR_UNRD {severity = warning} {msg = "The inout port '%s' declared in the %s '%s' is unread, but assigned"}
  KEY_NR_EWBG {severity = error}   {msg = "SystemVerilog keyword `end_keywords is used without `begin_keywords"}
  KEY_NR_SYSV {severity = error}   {msg = "Disallowed SystemVerilog keyword '%s' used"}
  LAT_NO_ALWS {severity = error}   {msg = "Partial or complete latch created of signal '%s', which is outside an always block in design unit '%s'"}
  LOP_NR_ARIT {severity = warning} {msg = "In design unit %s, an arithmetic expression '%s' not involving loop variable, found in for loop"}
  LOP_NR_ARNC {severity = warning} {msg = "In design-unit '%s', arithmetic operation '%s' found between loop variable and non-constant value"}
  LOP_NR_CTCE {severity = error}   {msg = "Design-unit '%s' contains a loop with a constant conditional expression '%s'"}
  LOP_NR_FCND {severity = error}   {msg = "Loop condition '%s' is false"}
  LOP_NR_IDTY {severity = warning} {msg = "Loop variable '%s' of the 'for' loop is not of recommended data type(s) (%s)"}
  LOP_NR_MLPV {severity = error}   {msg = "Value of loop variable '%s' modified within the loop"}
  LOP_NR_MSTP {severity = error}   {msg = "Loop step variable '%s' is different from the loop condition or initialization statement"}
  MAC_NR_DMUL {severity = warning} {msg = "Macro '%s' is defined with same definition"}
  MAC_NR_DUPF {severity = warning} {msg = "Macro is using duplicate formal name '%s', actual '%s' will be ignored"}
  MAC_NR_RDEF {severity = warning} {msg = "Macro '%s' is redefined"}
  MAC_NR_ODUT {severity = warning} {msg = "Macro '%s' used in module '%s' is defined outside design-unit"}
  MOD_NO_LGIC {severity = warning} {msg = "The design unit '%s' contains only declarations but has no logic inside"}
  MOD_NO_PRTD {severity = warning} {msg = "%s '%s' has %s ports"}
  MOD_NO_TMSL {severity = warning} {msg = "Timescale is missing for %s '%s' having delays"}
  MOD_NR_CASX {severity = warning} {msg = "'casex' statement used in design-unit '%s'"}
  MOD_NR_CELD {severity = warning} {msg = "`celldefine/`endcelldefine found inside design-unit '%s'"}
  MOD_NR_DEFP {severity = warning} {msg = "In module %s, defparam assignment to '%s' is not recommended"}
  MOD_NR_DSSL {severity = warning} {msg = "Design-unit '%s' contains declaration and statement '%s' in a single line"}
  MOD_NR_EBLK {severity = warning} {msg = "'%s' block inside design-unit '%s' does not contain any statement"}
  MOD_NR_ESTM {severity = warning} {msg = "Design-unit '%s' contains an empty statement"}
  MOD_NR_INCD {severity = warning} {msg = "The compiler directive %s is incomplete or used incorrectly in the design"}
  MOD_NR_MULD {severity = warning} {msg = "Design-unit '%s' contains multiple declarations '%s' in a single line"}
  MOD_NR_MULS {severity = warning} {msg = "Design-unit '%s' contains multiple HDL statements '%s' in a single line"}
  MOD_NR_PGAT {severity = warning} {msg = "Gate instance '%s' is not expected in an RTL design"}
  MOD_NR_PLIF {severity = warning} {msg = "PLI 1.0 function %s in design-unit '%s' is ignored"}
  MOD_NR_PRIM {severity = error}   {msg = "Primitive instance '%s' is not expected in an RTL design"}
  MOD_NR_RPXZ {severity = error}   {msg = "In design-unit '%s', repetition multiplier contains x/z"}
  MOD_NR_SYTS {severity = warning} {msg = "System task/function '%s' in design-unit '%s' is ignored"}
  MOD_NR_UNGN {severity = warning} {msg = "Unnamed generate block found in design-unit '%s'"}
  MOD_NS_EVNT {severity = warning} {msg = "In design-unit '%s' the use of named event '%s' is not supported"}
  REP_NR_ZERO {severity = warning} {msg = "In design unit '%s', all zero replication in concat expression '%s' is not recommended."}
  NAM_NR_REPU {severity = warning} {msg = "Identifier name '%s' reused with just case difference as %s"}
  OPR_NR_LOSD {severity = warning} {msg = "The result of the "%s" operation between constants in expression "%s" leads to truncation of bits and loss of data in design-unit/block %s. The bits getting lost are '%s'"}
  ROP_NR_OBIT {severity = warning} {msg = "In design unit '%s' reduction operation is performed on single-bit operand '%s'"}
  OPR_NR_REAL {severity = warning} {msg = "Real operand ('%s') is used in logical comparison"}
  OPR_NR_STRE {severity = error}   {msg = "String '%s' is used in the operation '%s' in %s '%s'"}
  OPR_NR_UCMP {severity = warning} {msg = "Unequal length operands in equality operator encountered in design-unit/block %s. LHS operand is %d bits, RHS operand is %d bits"}
  OPR_NR_UEOP {severity = warning} {msg = "Unequal length operand in bit operator %s in design-unit/block %s. LHS operand '%s' is %s bits, RHS operand '%s' is %s bits"}
  OPR_NR_UEAS {severity = warning} {msg = "Unequal length operand in arithmetic operator %s in design-unit/block %s. LHS operand '%s' is %s bits, RHS operand '%s' is %s bits"}
  OPR_NR_TERN {severity = warning} {msg = "Unequal length operand in ternary operator in design-unit/block %s. First operand '%s' is %s bits. Second operand '%s' is %s bits"}
  OPR_NR_UREL {severity = warning} {msg = "Unequal length operands in relational operator (padding produces incorrect result) in design-unit/block %s -- LHS operand is %d bits, RHS operand is %d bits"}
  OTP_NO_FDRV {severity = error}   {msg = "Bits '%s' of the output/inout are not driven in the design-unit '%s'"}
  OTP_NO_USED {severity = warning} {msg = "The output port '%s' declared in the %s '%s' is unused"}
  OTP_NR_READ {severity = warning} {msg = "Output port '%s' is read inside the design-unit '%s'"}
  OTP_NR_TSUP {severity = error}   {msg = "The output/inout '%s' is tied to supply0/supply1"}
  OTP_NR_UDRV {severity = error}   {msg = "Output/inout '%s' is not driven in the design-unit '%s'"}
  OTP_UC_INST {severity = warning} {msg = "Port '%s' (which is being used as an output) of design-unit '%s' is being driven inside the design, but not connected in its instance '%s'"}
  PAR_MS_SDAS {severity = warning} {msg = "Parameter '%s' has a size mismatch between its declaration and its value assigned, '%s' bits at declaration and '%s' bits at assigned value"}
  PRG_NO_EXPT {severity = error}   {msg = "Nested '%s' found inside '%s' block"}
  PRG_NR_PROF {severity = error}   {msg = "'%s' found without corresponding off pragma"}
  PRO_NR_WAIT {severity = warning} {msg = "Sensitivity lists should be used instead of wait statement '%s'"}
  PRT_NO_MODE {severity = warning} {msg = "In design-unit '%s', the port '%s' does not have a direction"}
  PRT_NR_BUFF {severity = error}   {msg = "Port '%s' should not be of mode buffer in design-unit '%s'"}
  PRT_NR_DFRG {severity = error}   {msg = "Port '%s' with range (%d to %d) is re-declared with a different range (%d to %d)"}
  PRT_NR_LINK {severity = error}   {msg = "Port '%s' should not be of mode linkage in design-unit '%s'"}
  REG_NO_READ {severity = warning} {msg = "Local register variable '%s' is not read, but is assigned at least once in %s '%s'"}
  REG_NO_USED {severity = warning} {msg = "Local register variable '%s' is unused (neither read nor assigned) in %s '%s'"}
  REG_NR_MBNT {severity = error}   {msg = "The notifier in timing check '%s' can not be greater than 1 bit"}
  REG_NR_UASR {severity = error}   {msg = "Local register variable '%s' is unassigned, but is read at least once in %s %s"}
  REP_NR_FORX {severity = error}   {msg = "In design-unit '%s', the replicated expression %s has 'x'"}
  REP_NR_MXSZ {severity = warning} {msg = "%s-bit replication multiplier '%s' found in design-unit '%s'"}
  REP_NR_NPOS {severity = error}   {msg = "Replication multiplier '%s' is negative in expression '%s'"}
  REP_NR_UPAC {severity = warning} {msg = "In design-unit '%s', replication %s is being assigned/mapped to an unpacked array"}
  RST_IS_CPLX {severity = error}   {msg = "In design-unit '%s', for flip-flop '%s', reset is an expression"}
  SIG_IS_ICST {severity = warning} {msg = "The signal '%h' is implicitly assigned as constant"}
  SIG_NO_ASIG {severity = error}   {msg = "VHDL signal '%s' is unassigned, but is read at least once in %s '%s'"}
  SIG_NO_READ {severity = warning} {msg = "VHDL signal '%s' is not read, but assigned at least once in %s '%s'"}
  SIG_NR_IDRG {severity = warning} {msg = "Index range of VHDL integer signal '%s' is '%d'"}
  SIG_NR_INDL {severity = warning} {msg = "A signal '%s' in an RTL description is initialized in its declaration"}
  TSK_NR_ASGV {severity = warning} {msg = "Task '%s' in design-unit '%s' assigns a value to global variable '%s'"}
  TSK_NR_ESDE {severity = warning} {msg = "Edge specified for data event '%s' in system task '%s'"}
  TSK_NR_FUNC {severity = warning} {msg = "Task '%s' used in a function '%s'"}
  TSK_NR_UGLV {severity = warning} {msg = "Variable '%s' used in task '%s' of design-unit '%s' is outside of the task scope"}
  VAR_NO_ASIG {severity = error}   {msg = "VHDL variable '%s' is unassigned, but is read at least once in %s '%s'"}
  VAR_NO_EVTR {severity = error}   {msg = "Event variable '%s' is unused"}
  VAR_NO_INTL {severity = error}   {msg = "Variable '%s' is not initialized before being incremented/decremented in the for loop"}
  VAR_NR_NEGT {severity = warning} {msg = "In design-unit '%s', the %s '%s' has a negative value"}
  VAR_NR_OUTL {severity = error}   {msg = "The loop variable '%s' is used outside the loop"}
  VAR_NR_PACK {severity = warning} {msg = "In module '%s', a concatenation expression is assigned to an unpacked variable "%s""}
  VAR_NR_PRCD {severity = warning} {msg = "Procedure '%s' in design-unit '%s' uses global VHDL variable '%s'"}
  VAR_NR_RDBA {severity = error}   {msg = "Signal/Variable '%s', is being read before getting assigned"}
  VAR_NR_RDEC {severity = error}   {msg = "Redeclaration of variable '%s' is not allowed"}
  VAR_NR_STRN {severity = error}   {msg = "Variable '%s' is of string datatype"}
  VAR_NR_UBDL {severity = error}   {msg = "Variable/Wire '%s' is used before declaration in design-unit '%s'"}
  WIR_NR_IMPL {severity = error}   {msg = "Variable/Wire '%s' has an implicit declaration in %s '%s'"}
  WIR_NR_UASR {severity = error}   {msg = "Wire '%s' declared in %s '%s' is unassigned, but drives at least an object"}
}


category SIM_SYNTH "Pre and post-synthesis simulation mismatch rules"
{
  ALW_NR_MSLV {severity = error}   {msg = "Signal '%s' appearing in the sensitivity list is modified inside the block"}
  ALW_NR_UNUV {severity = error}   {msg = "Signal '%s' appearing in the sensitivity list is not used in the '%s' block"}
  CAS_NR_FPIN {severity = warning} {msg = "In design-unit '%s', full_case pragma/priority case is used with a case statement having select expression '%s', is incomplete %s"}
  CAS_NR_PUOV {severity = warning} {msg = "In design-unit '%s', parallel_case pragma/unique case is used with a case statement having select expression '%s', in which some case items are overlapping"}
  CST_NO_BWID {severity = warning} {msg = "Bit width not specified for constant '%s'"}
  CST_NR_MSBX {severity = warning} {msg = "Extension of 'x' bits in a constant '%s'"}
  CST_NR_MSBZ {severity = warning} {msg = "Extension of 'z' bits in a constant '%s'"}
  DLY_NR_XZVL {severity = warning} {msg = "Delay value '%s' contains an x/z"}
  ENM_NR_TOST {severity = warning} {msg = "In design unit '%s', the data type '%s' of enum '%s' is of 2-state instead of 4-state"}
  FNC_NO_EVAL {severity = warning} {msg = "In design-unit '%s', function call '%s' might get blocked by logical operation"}
  MOD_NR_ACCD {severity = error}   {msg = "Access type '%s' is not supported in design-unit '%s'"}
  MOD_NR_LOCL {severity = error}   {msg = "Signal '%s' of task/function '%s' are initialized in design-unit '%s'"}
  MOD_NR_PRGD {severity = info}    {msg = "Synthesis directive '%s' found in file"}
  MOD_NR_SYXZ {severity = error}   {msg = "Synthesizing 'x'/'z' value '%s' in %s '%s'"}
  VAR_NR_MBNB {severity = error}   {msg = "In design-unit '%s', %s is assigned via both blocking and non-blocking assignments"}
  VAR_NR_NDCL {severity = error}   {msg = "Variable '%s' is declared as '%s'"}
}


category SYNTHESIS "Synthesizability rules"
{
  ALW_IC_SENL {severity = error}   {msg = "Sensitivity list of always block is incomplete in design-unit %s, missing variable(s): %s"}
  ALW_NO_COMB {severity = warning} {msg = "The variable '%s' models a %s in an 'always_comb' block"}
  ALW_NO_ETRG {severity = error}   {msg = "Always block with no event trigger at the start in design-unit '%s'"}
  ALW_NO_EVTS {severity = error}   {msg = "%s block with no event trigger at the start in %s %s"}
  ALW_NO_FFLP {severity = warning} {msg = "The variable '%s' models a %s in an 'always_ff' block"}
  ALW_NO_LATH {severity = warning} {msg = "The variable '%s' models a %s in an 'always_latch' block"}
  ALW_NR_MCLK {severity = error}   {msg = "Multiple clocks specified in variable %s of design-unit %s"}
  ALW_NR_MIFF {severity = error}   {msg = "Sensitivity list '%s' of always block containing 'iff' qualifiers, should be sensitive to at most one signal"}
  ALW_NR_MXCK {severity = error}   {msg = "Always block has both level and edge sensitive variables in its sensitivity list: %s"}
  ALW_NR_TCST {severity = error}   {msg = "The event expression '%s' cannot be synthesized"}
  ASG_NR_NBCB {severity = error}   {msg = "Non-blocking assignment at '%s' encountered in a combinational block"}
  ASG_NR_SUPN {severity = warning} {msg = "Assignment to a supply0/supply1 net %s in design-unit %s is ignored"}
  BLK_NR_PGDL {severity = error}   {msg = "The VHDL block header containing port/generic declaration found in design-unit %s is not synthesizable"}
  CAS_NR_EVLX {severity = error}   {msg = "In %s '%s', case item expressions evaluating to 'x/z/?' are ignored"}
  CLK_IS_NSYT {severity = error}   {msg = "Unable to synthesize clock for VHDL signal '%s' in design-unit '%s'"}
  CLK_NR_DDBE {severity = error}   {msg = "Clock %s for flip-flop %s is driving data on both edges"}
  CLK_NR_EDGE {severity = error}   {msg = "Clock %s for flip-flop %s does not drive any data. Wrong polarity specified"}
  CND_NR_CMXZ {severity = error}   {msg = "In design-unit '%s', conditional expression containing 'x'/'z' is statically evaluated to false"}
  CST_NR_CCAT {severity = warning} {msg = "In design-unit '%s', unsized literal '%s' in concatenation will be treated as 32 bits"}
  DLY_NR_ASGN {severity = warning} {msg = "Delay '%s' in assignment to '%s' is being ignored"}
  NOW_NS_FUNC {severity = error}   {msg = "'now' function in design-unit '%s' is not synthesizable"}
  FLP_NR_ASMX {severity = warning} {msg = "In the specified always/process block, descriptions of flip-flops with and without asynchronous reset are mixed. Flip-flops without asynchronous reset are: %s"}
  FLP_NR_BLAS {severity = warning} {msg = "In design-unit %s, flip-flop is assigned by blocking assignments"}
  FLP_NR_INDL {severity = error}   {msg = "The flip-flop output '%s' is initialized in its declaration or in initial block"}
  FLP_NR_MBCK {severity = error}   {msg = "In %s '%s', multi-bit '%s' used as clock for flip-flop '%s'"}
  FNC_NR_CREC {severity = error}   {msg = "Function '%s' is called recursively in %s '%s'"}
  FNC_NR_RESL {severity = warning} {msg = "Resolution function '%s' is found in design-unit '%s'"}
  IDX_NR_LBOU {severity = warning} {msg = "Variable index/range selection in LHS of assignment of '%s' is potentially outside the defined range"}
  IDX_NR_ORNG {severity = warning} {msg = "Variable index/range selection of '%s' is potentially outside the defined range"}
  IFC_NO_SENL {severity = warning} {msg = "If-condition '%s' does not match any sensitivity list edge"}
  INP_NR_ASGN {severity = error}   {msg = "Primary input port %s of design-unit %s may be driven inside the design-unit"}
  INS_NR_TOKN {severity = warning} {msg = "'.*' token is used '%s' times in the port list"}
  LAT_NR_BLAS {severity = warning} {msg = "In design-unit %s, latch is assigned by blocking assignments"}
  LAT_NR_MXCB {severity = warning} {msg = "The latches '%s' in the always block are mixed with combinational logic"}
  LOP_NR_GLID {severity = warning} {msg = "The loop variable '%s' is used in multiple always blocks"}
  LOP_NR_INFL {severity = error}   {msg = "%s '%s' contains a potential infinite loop"}
  LOP_NR_SRLG {severity = error}   {msg = "One or more flops has reset and logic section in the same '%s' loop with condition '%s'"}
  MOD_IS_RCMP {severity = warning} {msg = "Overwriting previous definition of %s '%s'"}
  MOD_NR_ALAS {severity = error}   {msg = "Design-unit %s has duplicate ports"}
  MOD_NR_ASLD {severity = warning} {msg = "In design-unit %s, the reset value of flip-flop %s is not constant. This infers an asynchronous load"}
  MOD_NR_CNDO {severity = warning} {msg = "In design-unit %s, %s comparison is treated as %s"}
  MOD_NR_DATT {severity = warning} {msg = "Attribute %s is overwritten in design unit %s"}
  MOD_NR_DSBC {severity = error}   {msg = "Design-unit %s contains non-synthesizable disable construct"}
  MOD_NR_EVRP {severity = error}   {msg = "%s %s contains event specification which cannot be synthesized"}
  MOD_NR_FINB {severity = error}   {msg = "Design-unit '%s' has a final block"}
  MOD_NR_FKJN {severity = error}   {msg = "%s %s contains non-synthesizable fork-join constructs"}
  MOD_NR_SPFY {severity = error}   {msg = "The module '%s' contains non-synthesizable specify block"}
  MOD_NR_FORE {severity = error}   {msg = "Design-unit %s contains forever construct"}
  MOD_NR_FREL {severity = error}   {msg = "%s %s contains non-synthesizable force/release constructs"}
  MOD_NR_IFSM {severity = warning} {msg = "%s %s contains implicit finite-state machine"}
  MOD_NR_INIB {severity = warning} {msg = "Design-unit '%s' has an initial block"}
  MOD_NR_NSLP {severity = error}   {msg = "%s %s contains non-static loop"}
  MOD_NR_NULP {severity = error}   {msg = "Module %s has null formal port(s)"}
  MOD_NR_PHYD {severity = error}   {msg = "Physical data type '%s' in design-unit '%s' is non-synthesizable"}
  MOD_NR_USWC {severity = error}   {msg = "%s %s contains non-synthesizable wait construct"}
  MOD_NS_ADAS {severity = error}   {msg = "Design-unit %s has assign/de-assign statements"}
  MOD_NS_DCSP {severity = error}   {msg = "Disconnect specification in design unit '%s' not supported"}
  MOD_NS_GTIN {severity = error}   {msg = "'%s' not supported"}
  OPR_NR_WCCO {severity = warning} {msg = "RHS Inside or wildcard equality operator (==? or !=?) is not constant in '%s'"}
  SIG_NO_HIER {severity = error}   {msg = "Design-unit '%s' has unsynthesizable hierarchical reference '%s'"}
  SIG_NO_UHIR {severity = error}   {msg = "Design-unit '%s' has unresolved hierarchical reference '%s'"}
  SIG_NR_MDRV {severity = warning} {msg = "VHDL signal '%s' in design-unit '%s', is being driven at edges of more than one signal or same signal with different edges"}
  SIG_NR_TIME {severity = error}   {msg = "Signal '%s' of data type 'time' used in %s %s"}
  TSK_NR_CLKE {severity = error}   {msg = "%s of variable '%s' used in task '%s'"}
  VAR_NO_COMR {severity = warning} {msg = "Variable index/range selection of '%s' is too small to access its defined range completely"}
  VAR_NR_MBLA {severity = warning} {msg = "In design-unit '%s', variable '%s' has multiple blocking assignments"}
  VAR_NR_MNBA {severity = warning} {msg = "In design-unit '%s', variable '%s' has multiple non-blocking assignments%s"}
  VAR_NR_OUTR {severity = error}   {msg = "Bit/part select '%s' is outside the defined range %s for '%s'"}
  VAR_NR_RDTA {severity = warning} {msg = "VHDL variable '%s' is used to register data"}
  VAR_NR_REAL {severity = error}   {msg = "Variable '%s' of data type 'real' used in %s %s"}
}

category STRUCTURAL "Structural rules"
{
  CLK_IS_BFFR {severity = warning} {msg = "Clock buffer '%h' is found in the design"}
  CLK_NO_INPT {severity = warning} {msg = "In design-unit '%m', clock '%l' driving one or more flip-flops, is not an input. One such flip-flop is '%l'"}
  CLK_NS_EDMX {severity = warning} {msg = "Both edges of clock '%s' used"}
  CLK_NR_GLKN {severity = warning} {msg = "The control signal '%s' of the gated clock '%s' is not a standard clock gate"}
  CMB_NR_TLIO {severity = warning} {msg = "Combinational path detected between top-level input '%s' and top-level output '%s'"}
  FLP_NO_ASRT {severity = error}   {msg = "Flip-flop '%s' does not have any asynchronous set or reset"}
  FLP_NR_ASRT {severity = error}   {msg = "Flip-flop '%s' has both asynchronous set and reset"}
  FLP_NR_ENCT {severity = warning} {msg = "Net '%h' driving enable pin of one or more flip-flops, is constant"}
  FLP_IS_STRH {severity = warning} {msg = "Potential data shoot-through between flip-flops: '%s' and '%s'"}
  LAT_IS_FLSE {severity = warning} {msg = "Latch '%h' is feeding latch '%h' having same enable %h"}
  LAT_IS_FFNE {severity = warning} {msg = "Latch '%s' is feeding flip-flop '%s' which is triggered at the negative edge of signal '%s', which is driving the enable of latch"}
  NET_IS_INTB {severity = warning} {msg = "Net '%l' defined in design-unit '%m', is inferred as a tri-state buffer"}
  TRI_NR_CSXZ {severity = error}   {msg = "Output of tristate buffer '%s' is used as casex/casez selector '%s'"}
  TRI_NR_IFTC {severity = error}   {msg = "Output of tristate buffer '%s' drives signal '%s'. It is used in %s condition"}
  NET_NO_DRIV {severity = error}   {msg = "Net '%s' declared in design-unit '%s' has no driver but has at least one load"}
  NET_NO_LDDR {severity = info}    {msg = "Net '%s' declared in design-unit '%s' neither has driver nor any load"}
  NET_NO_LOAD {severity = info}    {msg = "Net '%s' declared in design-unit '%s' has a driver but has no load"}
  REG_NO_LOAD {severity = warning} {msg = "Flip-flop/latch '%s' declared in design-unit '%s' does not have any load"}
  RST_IS_DCMB {severity = error}   {msg = "Net '%h' generated from combinational logic is driving reset of one or more flip-flops"}
  RST_IS_DFLP {severity = warning} {msg = "Net '%h' generated from flip-flop is driving reset of one or more flip-flops"}
  RST_IS_DLAT {severity = warning} {msg = "Net '%h' generated from latch is driving reset of one or more flip-flops"}
  RST_NR_MULT {severity = warning} {msg = "Flip-flop '%s' contains multiple asynchronous reset inputs"}
  RST_NR_PENA {severity = error}   {msg = "Net '%h' driving reset of one or more flip-flops, is permanently enabled"}
  SIG_IS_MDRV {severity = error}   {msg = "Net '%s' has multiple drivers"}
}

category RACES "Verilog Race condition rules"
{
  REG_NR_RWRC {severity = warning} {msg = "A read write race exists for signal: '%s'"}
  REG_NR_WWRC {severity = warning} {msg = "'%s' is written in more than one process/always block"}
  REG_NR_TRRC {severity = warning} {msg = "A trigger-propagation race exists between '%s' and '%s'"}
}

category BLACKBOX "Blackbox related rules"
{
  ELB_IS_ERRO {severity = error}   {msg= "Failed to elaborate design-unit '%s'. For more details check errors in the "Design Build" view"}
  INS_IS_EBXE {severity = info}    {msg = "Instance %s was explicitly blackboxed by user"}
  MOD_IS_EBXE {severity = info}    {msg = "Module/design-unit %s was explicitly blackboxed by user"}
  MOD_IS_IBXE {severity = warning} {msg = "Design-unit %s was implicitly blackboxed by the tool. Check for more details under the BBOX category in the "Design Build" view"}
  MOD_IS_RBXE {severity = warning} {msg = "Design-unit %s was blackboxed as a result of resilient compilation. Check for more details under the BBOX category in the "Design Build" view"}
  SIG_IS_ATBX {severity = warning} {msg = "%s '%s' is automatically blackboxed"}
}

category DFT_FUNCTIONAL "Functional mode DFT rules"
{
  CLK_IS_DLAT {severity = warning} {msg = "Signal '%h' generated from latch is driving clock of one or more flip-flops"}
  CLK_IS_NDPI {severity = warning} {msg = "Signal '%h' driving clock of one or more flip-flops, is undriven"}
  CLK_IS_BDPI {severity = warning} {msg = "Signal '%h' driving clock of one or more flip-flops is blackbox driven"}
  CLK_IS_CDPI {severity = warning} {msg = "Signal '%h' driving clock of one or more flip-flops is constant driven"}
  FLP_IS_ASFL {severity = error}   {msg = "Asynchronous feedback loop detected through reset/clock of flip-flop and '%s'"}
  FLP_IS_CKLP {severity = error}   {msg = "Feedback loop detected through clock of flip-flop and '%s'"}
  FLP_IS_CDFF {severity = warning} {msg = "Signal '%h' generated from a flip-flop is driving clock of one or more flip-flops"}
  FLP_IS_GTCK {severity = warning} {msg = "Signal '%s' generated from combinational logic is driving clock of one or more flip-flops"}
  FLP_NO_CNPI {severity = warning} {msg = "Reset signal '%h' of one or more flip-flops is undriven and is not generated from any primary input"}
  FLP_NO_SRST {severity = warning} {msg = "Flip-flop '%s' does not have any set or reset"}
  LAT_EN_NCPI {severity = warning} {msg = "Enable of latch '%s' is not controllable from primary inputs"}
  LAT_IS_CSTD {severity = warning} {msg = "Inferred latch '%' has a constant data input"}
  LAT_IS_INFR {severity = error}   {msg = "Process/always block models a latch, or signal '%s' is not assigned a value in all branches"}
  MOD_IS_CMBL {severity = error}   {msg = "Combinational loop detected passing through: '%h'"}
  NUM_IS_LOOP {severity = info}    {msg = "Loop processing stopped because threshold limit '%s' has been exceeded"}
  OTP_NO_RGTM {severity = warning} {msg = "Output '%h' of top-level module/design-unit is not registered"}
  RST_IS_DDAF {severity = warning} {msg = "Reset signal '%s' drives the data pin '%s' of one or more flip-flops/latches"}
  RST_MX_EDGE {severity = warning} {msg = "Signal '%s' is used as active-high reset as well as active-low reset"}
  RST_MX_SYAS {severity = error}   {msg = "Signal '%s' is used as both synchronous and asynchronous reset"}
  TRI_NO_EPTB {severity = error}   {msg = "Signal '%h' driving enable pin of the tristate buffer '%h' is not directly controllable by primary input(s)"}
}

category INTEGRATION "Hierarchical Analysis rules"
{
  CCN_IS_VRFD {severity = info}    {msg = "In capture mode, constraint '%s', for block '%s' has the same value which was used during block verification"}
  CCN_NO_VRFD {severity = error}   {msg = "In capture mode, constraint '%s', for block '%s' either has a different value then used during block verification or is not constant"}
  CON_IS_VRFD {severity = info}    {msg = "Constraint '%s', for block '%s' has the same value which was used during block verification"}
  CON_NO_VRFD {severity = error}   {msg = "Constraint '%s', for block '%s' either has a different value then used during block verification or is not constant"}
  ICK_NC_CCTL {severity = warning} {msg = "In capture mode, clock port '%h' in block '%s' is not connected to top-level test clock"}
  ICK_NC_FCTL {severity = warning} {msg = "Clock port '%h' in block '%s' is not connected to top-level clock port"}
  ICK_NC_SCTL {severity = warning} {msg = "In shift mode, clock port '%h' in block '%s' is not connected to top-level clock port"}
  IRS_NC_CCTL {severity = warning} {msg = "In capture mode, reset signal '%h' in block '%s' is not connected to top-level reset port"}
  IRS_NC_FCTL {severity = warning} {msg = "Reset port '%h' in block '%s' is not connected to top-level reset port"}
  IRS_NC_SCTL {severity = warning} {msg = "In shift mode, reset port '%h' in block '%s' is not connected to top-level reset port"}
  SCN_IS_VRFD {severity = info}    {msg = "In shift mode, constraint '%s', for block '%s' has the same value which was used during block verification"}
  SCN_NO_VRFD {severity = error}   {msg = "In shift mode, constraint '%s', for block '%s' either has a different value then used during block verification or is not constant"}
  SIG_MS_WIDT {severity = info}    {msg = "Size mismatch between the block level constraint for signal '%s' and the signal in instance '%s', constraint verification may not be proper"}
}

category TEST_COVERAGE "Test Coverage rules"
{
  FCV_IS_ESTM {severity = warning} {msg = "Fault coverage for design unit '%s' is %d"}
  FLT_IS_HTST {severity = warning} {msg = "Signal '%s' is hard to test because '%s' is low. As a result, all signals in the '%s' of this signal are hard to test"}
  TCV_IS_ESTM {severity = warning} {msg = "Testability coverage for design unit '%s' is %d"}
}

category AUTO_FORMAL_OVERFLOW
{
   ASG_AR_OVFL {severity = error} {msg = "Overflow in arithmetic assignment/assignment-like statement. LHS '%s' (%s) is of %s bit(s), RHS '%s' (%s) can be of %s bit(s)"}
   EXP_AR_OVFL {severity = error} {msg = "Overflow in expression. Expression size is %s bit(s), but expression value can be %s bit(s)"}
   ASG_IS_OVFL {severity = error} {msg = "Overflow in non-arithmetic assignment/assignment-like statement. LHS '%s' (%s) is of %s bit(s). RHS '%s' (%s) can be  %s bit(s)"}
   EXP_IS_DVBZ {severity = error} {msg = "Divide by zero condition found in expression. Divisor '%s' gets zero value"}
   SHF_IS_OVFL {severity = error} {msg = "Overflow as a result of shift operation. Shift expression size is %s bit(s), but expression value can be %s bit(s)"} {status=off}
   SHF_IS_ABSO {severity = error} {msg = "All bits of '%s' are shifted out in shift operation. The shifter value exceeds %s bit(s)"} {status=off}
   VAR_IS_CTOL {severity = error} {msg = "'%s' casting of variable '%s' results in change of value"} {status=off}
}


category AUTO_FORMAL_BUS
{
   BUS_IS_CONT {severity = error} {msg= "Contention bus failure found in bus '%s'"}
   BUS_IS_FLOT {severity = error} {msg= "Floating bus failure found in bus '%s'"}
   SIG_IS_MLAS {severity = error} {msg= "More than one assignment found for signal '%s'"} {status=off}
}


category AUTO_FORMAL_IF_CASE
{
  CAS_NO_PRIO {severity = error} {msg= "Priority case failure found for case with selector '%s'"}
  CAS_NO_UNIQ {severity = error} {msg= "Unique case failure found for case with selector '%s'"}
  CAS_IS_DFRC {severity = error} {msg= "A reachable default case was found for case with selector '%s'"} {status=off}
  IFC_NO_UNIQ {severity = error} {msg= "Unique if failure found for if with condition '%s' and condition '%s'"}
  SIG_IS_OHOT {severity = error} {msg= "More than one signal from the list '%s' are active-high"}
  SIG_IS_OCLD {severity = error} {msg= "More than one signal from the list '%s' are active-low"}
}


category AUTO_FORMAL_COMBO_LOOP
{
    MOD_IS_FCMB {severity = error} {msg= "Combinational loop detected passing through: '%s'"} {status=off}
}


category AUTO_FORMAL_DEAD_CODE
{
   BLK_NO_RCHB {msg= "The %s statement '%s' is not reachable%s%s"}
}


category AUTO_FORMAL_FSM_DEADLOCK_LIVELOCK
{
   FSM_IS_LVLK {severity = error} {msg= "Livelock condition found in the FSM '%s'"} {status=off}
   FSM_IS_DDLK {severity = error} {msg= "Deadlock condition found for state '%s' in the FSM '%s'"} {status=off}
   FSM_IS_PLLK {severity = warning} {msg= "Potential Livelock condition found in the FSM '%s'"} {status=off}
   FSM_IS_PDLK {severity = warning} {msg= "Potential Deadlock condition found for state '%s' in the FSM '%s'"} {status=off}
   FSM_IS_NLLK {severity = info} {msg= "FSM '%s' does not have any Livelock condition"} {status=off}
   FSM_IS_NDLK {severity = info} {msg= "State '%s' in the FSM '%s' does not have any Deadlock condition"} {status=off}
}

category AUTO_FORMAL_FSM_REACHABILITY
{
   FSM_NO_RCHB {severity = error} {msg= "Unreachable states found %s in the FSM '%s'"} {status=off}
   FSM_NO_TRRN {severity = error} {msg= "Unreachable transitions found %s->%s in the FSM '%s'"} {status=off}
   FSM_NO_MTRN {severity = error} {msg= "Unreachable consequence transitions %s->%s->%s found in the FSM '%s'"} {status=off}
}  
category AUTO_FORMAL_SIGNALS
{
   SIG_NO_TGRS {severity = error} {msg = "The signal '%s' has not toggled from 0 to 1"} {status=off}
   SIG_NO_TGFL {severity = error} {msg = "The signal '%s' has not toggled from 1 to 0"} {status=off}
   SIG_NO_TGST {severity = error} {msg = "The signal '%s' has not toggled stable"} {status=off}
   SIG_IS_DLCK {severity = error} {msg = "The signal '%s' has deadlock state %s"} {status=off}
   SIG_IS_STCK {severity = error} {msg = "The signal '%s' is stuck"} {status=off}
}

category AUTO_FORMAL_OUT_OF_BOUND_INDEXING
{
   ARY_IS_OOBI  {severity = error} {msg= "Variable index '%s' range selection greater than '%s' is outside the defined range of '%s'"}
}

category AUTO_FORMAL_X_ASSIGNMENT
{
   ASG_IS_XRCH {severity = error} {msg = "Signal '%s' was assigned with an 'x' value"} {status=off}
}

category AUTO_FORMAL_ASSERTION_CODING
{
  ASR_IS_CNFL {severity = error} {msg = "Assertion %s conflicts with one or more assertions in the design"} {status=off}
}

category DESIGN_OPTIMIZATION
{
  RST_IS_OPTZ {severity = Info} {msg = "Reset condition is not required for flop %s"} {status=off}
}

//***************************************************************************
//**    Following is the description of the default SUPERLINT parameters   **
//***************************************************************************

// *****************************
// Overall SUPERLINT parameters
// *****************************

// ***********************************************************
// **      Parameters for naming convention rules           **
// ***********************************************************
// In Superlint two parameters are used to control the regex style
// for naming convention rules
// 1. For regex style in general
//  params LINT {global_pattern_style="wildcard|regex"}
// 2. Local regex style for each naming convention rule
// params <rule_name> {local_pattern_style="regex|wildcard"}
//
// params LINT {global_pattern_style="wildcard|regex"} controls the regular
// expression style which is followed in Superlint globally
// and the 'pattern' parameter for the naming convention rule
// needs to be written according to the style selected.
// "wildcard" is the wildcard style which is
// same as used on the c shell command line and "regex" is the
// regex style regular expression.
// Default value is "regex"
// This global Superlint regex style can be overwritten for each
// naming rule locally by using the following parameter
// params <rule_name> {local_pattern_style="regex|wildcard"}
//
// example of "regex" regular expression
// params INS_NF_NMCV {pattern="^[a-zA-Z0-9]*_inst$"}
// This pattern will match any instance name which starts with
// allowable character set, that is, lower/upper case alphabets or number
// and should end with _inst

// example of "wildcard" regular expression
// params INS_NF_NMCV {pattern="*_inst"}
// This pattern will match any instance name which ends with _inst

params LINT {global_pattern_style=wildcard}
//params LINT {global_pattern_style=regex}

// *************************************************************
// Parameter to control the behavior of size matching rules
// in Verilog/SystemVerilog
// *************************************************************

// Parameter "unbased_literal" impacts the size calculation of the
// unsized literals, for example, integers. This will impact the behavior of
// all size related check such as OPR_NR_UCMP, OPR_NR_UREL, CAS_NR_UCIT, OPR_NR_UEOP, OPR_NR_UEAS etc. 
// where by default this parameter will be set to "size_as_per_type", integer size 
// will be taken as 32 bits irrespective of their value. If its value is set to
// "size_as_per_value" then size will be the number of bits in which
// integer can be accommodated. For example, size of 3 will be 2 bits.

params LINT {unbased_literal="size_as_per_type"}
//params LINT {unbased_literal="size_as_per_value"}

//The "size_as_per_calculation" parameter impacts all size-related rules.
//If this parameter is set to "yes", these rules consider calculated size.
//If it is set to "no", these rules consider LRM size.
//params LINT {size_as_per_calculation="yes"}
params LINT {size_as_per_calculation="no"}

// *******************************************************************
//  Parameter to control the behavior for partial unused vector,
//  if set to no, partially unused vector will be ignored.
// *******************************************************************
params LINT {report_partially_unused_vector="yes"}
//params LINT {report_partially_unused_vector="no"}


// *******************************************************************
//  Parameter to control the behavior for complex expressions,
//  if set to no, complex expressions set in array (prefixes/indices) would be ignored.
// *******************************************************************

//params LINT {report_complex_indexed_expr="yes"}
params LINT {report_complex_indexed_expr="no"}


// *******************************************************************
//  Parameter to control the supported bit size of signals
//  current bit size is 16384, user can modify this size to change limit.
// *******************************************************************
params LINT {max_supported_bit_size="16384"}


// *******************************************************************
//  The "case_selector_size_limit" parameter controls the supported bit size
//  of case selectors.
//  The default bit size is 14. Use this parameter to modify the size limit.
//  The maximum value is 32.
// *******************************************************************
params LINT {case_selector_size_limit ="14"}



// ******************************************************************
// *********** Parameter for controlling Blackbox ****************
// ******************************************************************
// This parameter controls how to treat blackboxed instance.
// if param is set to:
// all_bbox: assume all blackboxed instances are fully controllable/observable
// explicit_bbox: assume only explicitly blackboxed instances carefully controllable/observable
// no_bbox: assume blackboxed instances are neither controllable nor observable

//params LINT:DFT {assume_bbox_connected="all_bbox"}
//params LINT:DFT {assume_bbox_connected="explicit_bbox"}
//params LINT:DFT {assume_bbox_connected="no_bbox"}
params LINT:DFT {assume_bbox_connected="explicit_bbox"}


// *****************************************************************************
// ************Parameter for WIR_NR_UASR ***************************************
// *****************************************************************************
// This pattern parameter controls the behavior of WIR_NR_UASR
// rules. It specifies the pattern of the signal name on which these checks
// should not be reported.
// By default the rules are applied to all wires (datatype wire) in the module
// The 'pattern' here follows the same regex style as naming convention
// rules and is controlled by the same global parameters as naming convention
// rules.

params WIR_NR_UASR {pattern=""}

// *****************************************************************************
// ************Parameter for REG_NR_UASR  **************************************
// *****************************************************************************
// This pattern parameter controls the behavior of REG_NR_UASR:REG_NO_USED:REG_NO_READ
// rules. It specifies the pattern of the signal name on which these checks
// should not be reported.
// By default the rules are applied to all registers in the module
// The 'pattern' here follows the same regex style as naming convention
// rules and is controlled by the same global parameters as naming convention
// rules.

params REG_NR_UASR {pattern=""}


// **************************************************************
// The following parameter controls the behavior of CAS_NR_EXCS.
// params CAS_NR_EXCS {ignore_operator= "concat:replicate:add:subtract:multiply:divide:modulus"}
// By default, CAS_NR_EXCS is reported for all expressions used as
// case selectors except for expressions that use "concatenation"
// "replication","add","subtract","multiply","divide","modulus" operators.
// You can add to, or remove operators from this list.
// **************************************************************

params CAS_NR_EXCS {ignore_operator="concat:replicate:add:subtract:multiply:divide:modulus"}


// *******************************************************************
// Parameter to control the behavior of CND_IR_CCAS and  LOP_NR_CTCE
// *******************************************************************
// When the value of parameter 'optimize_condition' is set to 'yes', Tool
// optimizes conditional expressions for CND_IR_CCAS and LOP_NR_CTCE checks in the
// following cases:
//   * If any operand of the "logical AND" or "Bitwise AND" operation is false, the "AND/Bitwise AND"
//     operation evaluates to false.
//   * If any operand of the "logical OR" or "bitwise or" operation is true, the "OR/Bitwise OR"
//     operation evaluates to true.
// When the value of this parameter is set to 'no', these optimizations are not attempted.
// The default value of this parameter is 'yes'

params CND_IR_CCAS:LOP_NR_CTCE {optimize_condition="yes"}
//params CND_IR_CCAS:LOP_NR_CTCE {optimize_condition="no"}


// ****************************************************************
// ************Parameter for ARY_NR_SLRG **********************
// *******************************************************
// This parameter controls the behavior of ARY_NR_SLRG. If the value of
// the parameter is set to "no", one pin buses are checked on the
// entire design. If set to "yes", it is checked only on the top
// module. The default value is set to "no".

params ARY_NR_SLRG {top_only="no"}
//params ARY_NR_SLRG {top_only="yes"}


// ***********************************************************
// ** Parameters to control the direction range for arrays  **
// ***********************************************************

// Default direction for range in array/vector declarations is "descending".
// This can be changed to "ascending", if that is preferred.  This
// only affects the ARY_MS_DRNG check.

// params ARY_MS_DRNG {direction="ascending"}
params ARY_MS_DRNG {direction="descending"}

// By default ARY_MS_DRNG reports for both packed and unpacked dimensions of arrays.
// When this parameter is explicitly set to "no" the tool will not check the
// unpacked dimensions of arrays.

params ARY_MS_DRNG {report_unpacked="yes"}
//params ARY_MS_DRNG {report_unpacked="no"}

// The parameter "skip_unused_signal" allows the user to control the behavior of ARY_MS_DRNG.
// When the parameter value is set to "yes", ARY_MS_DRNG is not reported for unused signals.
// However, if the parameter value is set to "no", ARY_MS_DRNG is reported for unused
// signals. The default value of this parameter is set to "no".
params ARY_MS_DRNG {skip_unused_signal = "no"}
//params ARY_MS_DRNG {skip_unused_signal = "yes"}

// By default, following check is not issued on component declaration
// If parameter is set to 'no' then this check is performed on component declaration also.
//params ARY_MS_DRNG {skip_component_declaration="no"}
params ARY_MS_DRNG {skip_component_declaration="yes"}


// **************************************************************
// ******* Parameter for controlling INS_NR_PTEX**********
// **************************************************************
// This parameter controls the behavior of INS_NR_PTEX. If the value of
// this parameter is set to "no", INS_NR_PTEX is reported for sized as
// well as unsized literals. If the parameter is set to "yes", INS_NR_PTEX
// is not reported for sized literals. The default value is set to "yes".

params INS_NR_PTEX {ignore_sized_literal="yes"}
//params INS_NR_PTEX {ignore_sized_literal="no"}

// ***********************************************************
// **  Parameters to control the behavior of INS_NR_PODL check **
// ***********************************************************

// The following parameter controls whether the INS_NR_PODL messages should
// be issued for library cells that is
// modules with `celldefine statement in Verilog.
// By default, LINT will flag this check for technology cells instantiated
// in the design.

params INS_NR_PODL {check_tech_cells="yes"}
// params INS_NR_PODL {check_tech_cells="no"}

// ***********************************************************
// **  Parameters to control the behavior of VAR_NR_NEGT check **
// ***********************************************************

// The following parameter allows user to control the datatypes
// on which VAR_NR_NEGT check should be reported. By default,
// it is "reg:logic:wire" which means violation will be reported
// for all of them.

params VAR_NR_NEGT {check_datatype="reg:logic:wire"}
// params VAR_NR_NEGT {check_datatype=""}


// ***********************************************************
// **  Parameter to control the behavior of ALW_NR_UNUV check **
// ***********************************************************

// The following parameter controls the behavior of the ALW_NR_UNUV check.
// If this parameter is set to "yes", the tool issues a violation on any
// partially unread part of the vector. If this parameter is set to "no",
// the tool issues no violation if any bit of the vector is read. By default,
// the value of this parameter is "yes".

params ALW_NR_UNUV {report_partially_read_vector="yes"}
//params ALW_NR_UNUV {report_partially_read_vector="no"}

// *****************************************************************************
// ** Parameter to control the behavior of CAS_NR_CMUL checks **
// *****************************************************************************

// The parameter "report_non_constant_case_item" controls
// the behavior of CAS_NR_CMUL. When this parameter is set
// to "yes", the tool reports CAS_NR_CMUL for non-constant
// duplicate case items. However, if this parameter is set
// to "no", the tool does not report CAS_NR_CMUL for
// non-constant duplicate case items. The default value of
// this parameter is "no".
params CAS_NR_CMUL {report_non_constant_case_item ="no"}
//params CAS_NR_CMUL {report_non_constant_case_item ="yes"}

// *****************************************************************************
// ** Parameter to control the behavior of CAS_NR_OVCI and CAS_NR_CMUL checks **
// *****************************************************************************

// The "consider_parallel_case_pragma" paramater controls the behavior of
// CAS_NR_OVCI and CAS_NR_CMUL. If this parameter is set to "no", the tool
// reports the violation when a parallel_case pragma is used with a case
// statement that has overlapping case items. When "consider_parallel_case_pragma"
// is set to "yes", the violation is not reported in scenarios where
// a parallel_case pragma is used with a case statement that has overlapping
// case items. By default, this parameter is disabled. Use caution when
// enabling this parameter to avoid any unwanted masking of issues.
params CAS_NR_OVCI:CAS_NR_CMUL {consider_parallel_case_pragma ="no"}
//params CAS_NR_OVCI:CAS_NR_CMUL {consider_parallel_case_pragma ="yes"}

// ***********************************************************
// Parameters to control the behavior of CAS_NR_DEFN / CAS_NR_FPIN
// ***********************************************************
params CAS_NR_DEFN:CAS_NR_FPIN {full_case_with_no_default_allowed="yes"}
//params CAS_NR_DEFN:CAS_NR_FPIN {full_case_with_no_default_allowed="no"}

// When the 'combinational_block_only' is set to 'yes',
// then the tool will issue a message CAS_NR_DEFN ONLY if, the
// case block appears in a pure combinational block.
// Alternatively, when set to 'no',
// the tool will issue a message CAS_NR_DEFN/CAS_NR_FPIN,
// for both combinational as well as sequential blocks.
// The default value of this parameter is 'no'.

params CAS_NR_DEFN:CAS_NR_FPIN {combinational_block_only="no"}
//params CAS_NR_DEFN:CAS_NR_FPIN {combinational_block_only="yes"}

// when the 'consider_default_item_as_full' is set to 'no', we will not consider
// case statement as full if case items are incomplete and default is provided
// if value is 'yes', then we consider item as full if default is available, even if items are incomplete.
params CAS_NR_DEFN:CAS_NR_FPIN {consider_default_item_as_full="yes"}
//params CAS_NR_DEFN:CAS_NR_FPIN {consider_default_item_as_full="no"}

// When the parameter is "yes", if all the enum values for the case selector are covered,
// tool does not report any violation.
params CAS_NR_DEFN:CAS_NR_FPIN {consider_all_enum_covered_as_full="no"}
//params CAS_NR_DEFN:CAS_NR_FPIN {consider_all_enum_covered_as_full="yes"}

// ***********************************************************
// ** Parameter to control the behavior of CAS_NR_DEFN check **
// ***********************************************************

// The following parameter allows you to control the behavior of
// CAS_NR_DEFN and CAS_NR_DEFX. If consider_full_case
// as_full="no", the tool reports a violation when full_case pragma
// is used with incomplete case statement. Whereas, when consider
// full_case_as_full="yes", a violation is not reported in
// scenarios where full_case pragma is used with incomplete case
// statement. By default, this parameter is disabled. Enable this
// parameter with caution, to avoid any unwanted masking of issues.
params CAS_NR_DEFN:CAS_NR_DEFX {consider_full_case_as_full="no"}
//params CAS_NR_DEFN:CAS_NR_DEFX {consider_full_case_as_full="yes"}


// ***********************************************************
// ** Parameters to control the behavior of CAS_NR_DEFX check **
// ***********************************************************

// The parameter "skip_incomplete_case" allows the user to
// control the behavior of CAS_NR_DEFX. If the value of
// parameter is set to "no", tool will report violation when
// default clause is not assigned 'x' for incomplete case
// statement. However, if the parameter is set to "yes",
// tool will not report this violation for incomplete case
// statement. By default, the value is set to "no".
params CAS_NR_DEFX {skip_incomplete_case="no"}
//params  CAS_NR_DEFX {skip_incomplete_case="yes"}

// The parameter "consider_full_case_as_full" allows the user
// to control the behavior of CAS_NR_DEFX. If the parameter
// value is set to "yes", the tool considers incomplete case
// statements with full_case pragma as full. Whereas, when
// this parameter is set to "no", the tool considers incomplete
// case statements as incomplete even if full_case pragma is
// mentioned. By default, the value is set to "no".
params CAS_NR_DEFX {consider_full_case_as_full="no"}
//params CAS_NR_DEFX {consider_full_case_as_full="yes"}

// The parameter "consider_all_enum_covered_as_full" allows the user
// to control the behavior of CAS_NR_DEFX. When the parameter value
// is set to "yes", if all the enum values for the case selector are
// covered the tool considers case statement as full/ complete.
// However, if the parameter value is set to "no", the tool does not
// consider case statement as full even if all the enum values for the
// case selector are covered. The default value of this parameter is set to "no".
params CAS_NR_DEFX {consider_all_enum_covered_as_full="no"}
//params CAS_NR_DEFX {consider_all_enum_covered_as_full="yes"}


// ***********************************************************
// Parameter to control the behavior of ALW_NR_TCST
// ***********************************************************
// This parameter controls the behavior of ALW_NR_TCST. When
// the parameter "check_edge_sensitive_only" is set to "no",
// the violation is reported for both edge and level-sensitive
// always blocks. When this parameter is set to "yes", ALW_NR_TCST
// is reported for edge-sensitive always blocks only.
// The default value of this parameter is "yes".

params ALW_NR_TCST {check_edge_sensitive_only="yes"}
//params ALW_NR_TCST {check_edge_sensitive_only="no"}


// ***********************************************************
// Parameter to control the behavior of CST_NR_REAL
// ***********************************************************
// This parameter controls the behavior of CST_NR_REAL. When
// the parameter "check_case_only" is set to "yes",
// the violation is reported only when real constant is used inside case items.
// When this parameter is set to "no", CST_NR_REAL
// is reported when real constants are used, irrespective of where they are used.
// The default value of this parameter is "no".

params CST_NR_REAL {check_case_only="no"}
//params CST_NR_REAL {check_case_only="yes"}

// ***********************************************************
// Parameters to control the behavior of OTP_NR_READ
// ***********************************************************
// When 'skip_assigned_output' is set to 'yes',
// the tool does not issue an OTP_NR_READ message if
// the output port is assigned as well.
// Alternatively, if set to 'no', the tool issues OTP_NR_READ
// even if the output is assigned.
// The default value of this parameter is 'no'.

params OTP_NR_READ {skip_assigned_output="no"}
//params OTP_NR_READ {skip_assigned_output="yes"}


// ***********************************************************
// Parameter to control the behavior of EXP_NR_TNST
// ***********************************************************
// Parameter 'nesting_limit' is used to specify the maximum supported ternary nesting
// The default value of the parameter is 10.

params EXP_NR_TNST {nesting_limit="10"}


// *******************************************************************
//  Parameter to control the behavior for FLP_NR_MBCK,
//  if set to yes, FLP_NR_MBCK will be reported on bus clock signal
// *******************************************************************
params FLP_NR_MBCK {clock_using_bus_signal="no"}
//params FLP_NR_MBCK {clock_using_bus_signal="yes"}


// *******************************************************************
//  Parameter to control whether the rule MOD_NR_SYXZ need to report on 'x', 'z'
//  or both.
// *******************************************************************
params MOD_NR_SYXZ {report_value_type="both"}
//params MOD_NR_SYXZ {report_value_type="x"}
//params MOD_NR_SYXZ {report_value_type="z"}

//****************************************************************
// ** Parameter to control the behavior of VAR_NR_NDCL ***********
//****************************************************************
// This parameter controls the list of primitives to ignore.
// To ignore a primitive, write the name of the primitive in the parameter.
// Use an ':' sign to separate multiple primitives.
params VAR_NR_NDCL {ignore_primitive=""}

// *******************************************************************
//  Parameters to control the behavior of Combinational Loops found in the design:
//
//  disable_enumerated_loops: When set to "no", if one signal is part of
//  multiple loops, then tools issues message for all such loops. Setting
//  the value to "yes" will issue message only once.
//
//  loop_unroll_limit: All loops passing through subset of common connected signals
//  are marked as strongly connected and categorized as one strongly connected loop.
//  This parameter controls the number of enumerated loops reported for each strongly
//  connected loop.
// *******************************************************************
params MOD_IS_CMBL {disable_enumerated_loops="no"}
//params MOD_IS_CMBL {disable_enumerated_loops="yes"}

params MOD_IS_CMBL {loop_unroll_limit="10"}
//params MOD_IS_CMBL {loop_unroll_limit="0"}

// *****************************************************************************
// ************Parameter for OTP_UC_INST:INP_UC_INST  **************
// *****************************************************************************
// The following parameter controls the settings for OTP_UC_INST:INP_UC_INST rule
// If 'ignore_explicitly_unconnected_port' is set to 'yes',
// then the tool will not report OTP_UC_INST:INP_UC_INST for explicitly
// unconnected input ports.

params OTP_UC_INST:INP_UC_INST {ignore_explicitly_unconnected_port="no"}
// params OTP_UC_INST:INP_UC_INST {ignore_explicitly_unconnected_port="yes"}

// The following parameter controls the settings for OTP_UC_INST:INP_UC_INST rule
// If 'report_partially_unused' is set to 'yes',
// then the tool will report OTP_UC_INST:INP_UC_INST for signals that are partially 
// unconnected input ports.
// If 'report_partially_unused' is set to 'yes',
// then the tool will report only in the case when there are no bits connected

params OTP_UC_INST:INP_UC_INST {report_partially_unused="yes"}
// params OTP_UC_INST:INP_UC_INST {report_partially_unused="no"}

// The following parameter controls the settings for the
// OTP_UC_INST:INP_UC_INST:INP_NO_LOAD:OTP_NO_FDRV:OTP_NR_UDRV
// rules. If the 'ignore_inout_ports' is set to 'yes', the
// tool ignores inout ports and no violations of
// OTP_UC_INST:INP_UC_INST:INP_NO_LOAD:OTP_NO_FDRV:OTP_NR_UDRV
// are reported. If the 'ignore_inout_ports' is set to 'no',
// the tool reports INP_UC_INST or INP_NO_LOAD if inout port is
// behaving like input port and OTP_UC_INST, OTP_NO_FDRV, OTP_NR_UDRV
// if inout port is behaving like output port.


params OTP_UC_INST:INP_UC_INST:INP_NO_LOAD:OTP_NO_FDRV:OTP_NR_UDRV {ignore_inout_ports="no"}
//params OTP_UC_INST:INP_UC_INST:INP_NO_LOAD:OTP_NO_FDRV:OTP_NR_UDRV {ignore_inout_ports="yes"}


// ***************************************************************
// ** Parameter to the control the behavior of the check SIG_IS_MDRV **
// ***************************************************************
// By default, the rule SIG_IS_MDRV will be flagged if a signal
// has more than one driver and none of the multiple drivers are
// driven by 'Z'. This rule does not consider the 'Z' driver
// as a valid driver and will ignore that driver. This behavior can be
// changed by the parameter 'ignore_z_drivers'
// When the parameter 'ignore_z_drivers' is set to "no", and if a
// signal has two drivers. And one of the drivers is 'Z', then the
// tool will consider the 'Z' driver as a valid driver and the check
// will be reported.
// Alternatively, when the parameter is set to 'yes', the tool will
// allow the signal to have a 'Z' driver and not flag the check.
// The default value of this parameter is set to "yes".

params SIG_IS_MDRV {ignore_z_drivers="yes"}
//params SIG_IS_MDRV {ignore_z_drivers="no"}

//When the parameter 'report_same_drivers" is set to "no" ,the tool does
//not flag the check when the drivers are same. When the parameter
//'report_same_drivers' is set to "yes" , the tool flags the check even when
//drivers are same. Default value for this parameter is set to "no"

params SIG_IS_MDRV {report_same_drivers="no"}
//params SIG_IS_MDRV {report_same_drivers="yes"}


// **************************************************************
// ******* Parameter for controlling ALW_NR_MSLV ********
// **************************************************************
// This parameter controls the behavior of ALW_NR_MSLV. If the value
// of parameter is set to "yes", then tool with not report ALW_NR_MSLV
// for signals which were also read in the same always/ process block.
// By default, value is "no"
params ALW_NR_MSLV {skip_read_and_assigned="no"}
//params ALW_NR_MSLV {skip_read_and_assigned="yes"}


// This parameter controls the behavior of ALW_NR_MSLV. If the value
// of parameter is set to "no", then tool with report ALW_NR_MSLV
// inside always @* for implicit sensitivity list
// By default, value is "yes"
params ALW_NR_MSLV {skip_implicit_sensitivity_list="yes"}
//params ALW_NR_MSLV {skip_implicit_sensitivity_list="no"}

// **************************************************************
// ******* Parameter for controlling RST_MX_EDGE **********
// **************************************************************
params RST_MX_EDGE {convention_for_set_reset_style="mixed"}
//params RST_MX_EDGE {convention_for_set_reset_style="asynchronous"}
//params RST_MX_EDGE {convention_for_set_reset_style="synchronous"}


//***********************************************************
// ** Parameter to control the behavior of LAT_EN_NCPI ***********
//***********************************************************
// If the enable of a latch is controllable by primary inputs
// through some combinational logic, LINT does not consider it to be
// controllable. However, you can use the following parameter to change
// this default behavior, and consider the enable of a latch
// driven through combinational logic as controllable if any net in the
// combinational logic is controlled by a primary input.

params LAT_EN_NCPI {controllable_thru_comb_logic="no"}
// params LAT_EN_NCPI {controllable_thru_comb_logic="yes"}


// ***********************************************************
// ** Parameter to disable CAS_NR_OVCI on 'Z' overlap**
// ***********************************************************
//This parameter controls the behavior of MULCAS. If the value
//of parameter is set to "yes", then tool with not check MULCAS
//for z overlap. By default, value is "no"

params CAS_NR_OVCI {ignore_z_overlap ="no"}
params CAS_NR_OVCI {ignore_within_list_overlap ="no"}
params CAS_NR_OVCI {ignore_overlap_except_unique ="no"}


// *******************************************************************
// *********** Parameter for controlling OTP_NR_UDRV:OTP_NO_FDRV *****
// *******************************************************************
// Parameter to control the behavior of OTP_NR_UDRV:OTP_NO_FDRV. When the 'top_only' is
// set to 'yes', then the tool will check for OTP_NR_UDRV:OTP_NO_FDRV only for TOP level
// modules. Alternatively, when set to 'no', the tool will check for
// OTP_NR_UDRV:OTP_NO_FDRV for all the modules. The default value of 'top_only' is set
// to 'no'

params OTP_NR_UDRV:OTP_NO_FDRV {top_only="no"}
//params OTP_NR_UDRV:OTP_NO_FDRV {top_only="yes"}

// This parameter controls the behaviour of the OTP_NR_UDRV:OTP_NO_FDRV check.
// When 'ignore_unloaded_ports' is set to 'yes', the tool ignores ports that
// do not have fanouts. When set to 'no', the violation is thrown
// for all undriven output ports. The default value of 'ignore_unloaded_ports'
// is 'yes'.

params OTP_NR_UDRV:OTP_NO_FDRV {ignore_unloaded_ports="yes"}
//params OTP_NR_UDRV:OTP_NO_FDRV {ignore_unloaded_ports="no"}

// *******************************************************************
// *********** Parameter for controlling INP_NO_LOAD *****************
// *******************************************************************
// This parameter controls the behavior of INP_NO_LOAD check.
// When 'ignore_undriven_ports' is set to 'yes', tool will ignore ports which
// does not have fanins. When set to 'no', the violation will be thrown
// for all the unloaded input ports. The default value of 'ignore_undriven_ports'
// is set to 'yes'

params INP_NO_LOAD {ignore_undriven_ports="yes"}
//params INP_NO_LOAD {ignore_undriven_ports="no"}


// *******************************************************************
// *********** Parameter for controlling MOD_NO_IPRG *****************
// *******************************************************************
// This parameter controls the behavior of MOD_NO_IPRG. The value given
// in the parameter is used to define the maximum number of levels of combinational
// logic that should be present before a flip-flop is encountered.
// The default value is "0".

//params MOD_NO_IPRG {levels_of_combinational_logic="0"}


// *******************************************************************
// *********** Parameter for controlling OTP_NO_RGTM *****************
// *******************************************************************
// This parameter controls the behavior of OTP_NO_RGTM. The value given
// in the parameter is used to define the maximum number of levels of combinational
// logic that should be present before a flip-flop is encountered.
// The default value is "0".

params OTP_NO_RGTM {levels_of_combinational_logic="0"}


// *******************************************************************
// *********** Parameter for controlling CST_NO_BWID *****************
// *******************************************************************
// This parameter controls the behavior of CSTBWD when the binary
// number system is used to define constants. The default value of this
// parameter is "5", which indicates that the check is reported for
// constants of five bits or more
// for binary system

params CST_NO_BWID {bit_width_allowed_bin_system="5"}

// for other system :hexadecimal, octal etc
params CST_NO_BWID {bit_width_allowed_other_system="5"}


// ******************************************************************
// *********** Parameter for controlling CAS_NR_UCIT ****************
// ******************************************************************
// This parameter controls the behavior of CAS_NR_UCIT check.
// If this parameter is set to yes, this check is ignored
// when selector is less than the case tags.
//params CAS_NR_UCIT {casesel_lessthan_casetag_allow="yes"}
params CAS_NR_UCIT {casesel_lessthan_casetag_allow="no"}

// if parameter allow_padding_by_zero is set to "yes" then
// CAS_NR_UCIT check is reported due to padding of 0s,
// will not be thrown, applicable over constants only.

// if parameter allow_truncation_by_zero is set to "yes" then
// CAS_NR_UCIT check is reported due to truncation of 0s,
// will not be thrown, applicable over constants only.

//params CAS_NR_UCIT {allow_truncation_by_zero="no"}
params CAS_NR_UCIT {allow_truncation_by_zero="yes"}
//params CAS_NR_UCIT {allow_padding_by_zero="no"}
params CAS_NR_UCIT {allow_padding_by_zero="yes"}


// ******************************************************************
// *********** Parameter for controlling OPR_NR_UREL ****************
// ******************************************************************
// if parameter allow_padding_by_zero is set to "yes" then
// OPR_NR_UREL check is reported due to padding of 0s,
// will not be thrown, applicable over constants only.

// if parameter allow_truncation_by_zero is set to "yes" then
// OPR_NR_UREL check is reported due to truncation of 0s,
// will not be thrown, applicable over constants only.

//params OPR_NR_UREL {allow_truncation_by_zero="no"}
params OPR_NR_UREL {allow_truncation_by_zero="yes"}
//params OPR_NR_UREL {allow_padding_by_zero="no"}
params OPR_NR_UREL {allow_padding_by_zero="yes"}


// ******************************************************************
// *********** Parameter for controlling FNC_MS_AFPR ****************
// ******************************************************************
// if parameter allow_padding_by_zero is set to "yes" then
// FNC_MS_AFPR check is reported due to padding of 0s,
// will not be thrown, applicable over constants only.

// if parameter allow_truncation_by_zero is set to "yes" then
// FNC_MS_AFPR check is reported due to truncation of 0s,
// will not be thrown, applicable over constants only.

//params FNC_MS_AFPR {allow_truncation_by_zero="no"}
params FNC_MS_AFPR {allow_truncation_by_zero="yes"}
//params FNC_MS_AFPR {allow_padding_by_zero="no"}
params FNC_MS_AFPR {allow_padding_by_zero="yes"}


// ******************************************************************
// *********** Parameter for controlling INS_MS_PSIZ ****************
// ******************************************************************
// if parameter allow_padding_by_zero is set to "yes" then
// INS_MS_PSIZ check is reported due to padding of 0s,
// will not be thrown, applicable over constants only.

// if parameter allow_truncation_by_zero is set to "yes" then
// INS_MS_PSIZ check is reported due to truncation of 0s,
// will not be thrown, applicable over constants only.

//params INS_MS_PSIZ {allow_truncation_by_zero="no"}
params INS_MS_PSIZ {allow_truncation_by_zero="yes"}
//params INS_MS_PSIZ {allow_padding_by_zero="no"}
params INS_MS_PSIZ {allow_padding_by_zero="yes"}


// ******************************************************************
// *********** Parameter for controlling ARY_NR_LOPR ****************
// ******************************************************************
// if parameter allow_truncation_by_zero is set to "yes" then
// ARY_NR_LOPR check is reported due to truncation of 0s,
// will not be thrown, applicable over constants only.

//params ARY_NR_LOPR {allow_truncation_by_zero="no"}
params ARY_NR_LOPR {allow_truncation_by_zero="yes"}


// ******************************************************************
// *********** Parameter for controlling OPR_NR_UCMP ****************
// ******************************************************************
// if parameter allow_padding_by_zero is set to "yes" then
// OPR_NR_UCMP check is reported due to padding of 0s,
// will not be thrown, applicable over constants only.

// if parameter allow_truncation_by_zero is set to "yes" then
// OPR_NR_UCMP check is reported due to truncation of 0s,
// will not be thrown, applicable over constants only.

//params OPR_NR_UCMP {allow_truncation_by_zero="no"}
params OPR_NR_UCMP {allow_truncation_by_zero="yes"}
//params OPR_NR_UCMP {allow_padding_by_zero="no"}
params OPR_NR_UCMP {allow_padding_by_zero="yes"}


// ******************************************************************
// *********** Parameter for controlling OPR_NR_UEOP ****************
// ******************************************************************
// if parameter allow_padding_by_zero is set to "yes" then
// OPR_NR_UEOP check is reported due to padding of 0s,
// will not be thrown, applicable over constants only.

// if parameter allow_truncation_by_zero is set to "yes" then
// OPR_NR_UEOP check is reported due to truncation of 0s,
// will not be thrown, applicable over constants only.

//params OPR_NR_UEOP {allow_truncation_by_zero="no"}
params OPR_NR_UEOP {allow_truncation_by_zero="yes"}
//params OPR_NR_UEOP {allow_padding_by_zero="no"}
params OPR_NR_UEOP {allow_padding_by_zero="yes"}


// ******************************************************************
// *********** Parameter for controlling OPR_NR_UEAS ****************
// ******************************************************************
// if parameter allow_padding_by_zero is set to "yes" then
// OPR_NR_UEAS check is reported due to padding of 0s,
// will not be thrown, applicable over constants only.

// if parameter allow_truncation_by_zero is set to "yes" then
// OPR_NR_UEAS check is reported due to truncation of 0s,
// will not be thrown, applicable over constants only.

//params OPR_NR_UEAS {allow_truncation_by_zero="no"}
params OPR_NR_UEAS {allow_truncation_by_zero="yes"}
//params OPR_NR_UEAS {allow_padding_by_zero="no"}
params OPR_NR_UEAS {allow_padding_by_zero="yes"}

// ******************************************************************
// *********** Parameter for controlling OPR_NR_TERN ****************
// ******************************************************************
// if parameter allow_padding_by_zero is set to "yes" then
// OPR_NR_TERN check is reported due to padding of 0s,
// will not be thrown, applicable over constants only.

// if parameter allow_truncation_by_zero is set to "yes" then
// OPR_NR_TERN check is reported due to truncation of 0s,
// will not be thrown, applicable over constants only.

//params OPR_NR_TERN {allow_truncation_by_zero="no"}
params OPR_NR_TERN {allow_truncation_by_zero="yes"}
//params OPR_NR_TERN {allow_padding_by_zero="no"}
params OPR_NR_TERN {allow_padding_by_zero="yes"}

// ******************************************************************
// *********** Parameter for controlling INS_MS_PRMS ****************
// ******************************************************************
// if parameter allow_truncation_by_zero is set to "yes" then
// INS_MS_PRMS check is not reported due to truncation of 0s,
// if actual parameter size is greater than formal parameter size,
// applicable over constants only.
//params INS_MS_PRMS {allow_truncation_by_zero="no"}
params INS_MS_PRMS {allow_truncation_by_zero="yes"}

// if parameter allow_padding_by_zero is set to "yes" then
// INS_MS_PRMS check is not reported due to padding of 0s,
// if actual parameter size is less than formal parameter size,
// applicable over constants only.
//params INS_MS_PRMS {allow_padding_by_zero="no"}
params INS_MS_PRMS {allow_padding_by_zero="yes"}

// ******************************************************************
// *********** Parameter for controlling IDX_NR_DTTY ****************
// ******************************************************************
// This parameter controls the behavior of IDX_NR_DTTY check.
// The check is currently issued when index is of type reg, logic or
// integer. Using this parameter following data types can be allowed
//params IDX_NR_DTTY {allowed_datatypes="reg:integer:logic"}
params IDX_NR_DTTY {allowed_datatypes="reg"}


// ******************************************************************
// *********** Parameter for controlling CMB_NR_TLIO ****************
// ******************************************************************
// This parameter controls the behavior of CMB_NR_TLIO check.
// The check is currently not reported when the path from output to
// input goes through a latch, when the value of the parameter is
// set to "yes", such paths are also reported.
//params CMB_NR_TLIO {report_with_latch_in_path="yes"}
params CMB_NR_TLIO {report_with_latch_in_path="no"}


// ******************************************************************
// ***************** Parameter to control Where checks are reported
// ******************************************************************

// By default, following checks are not issued on wire, variable, parameter, enum declarations.
// If parameter is set to 'no' then these checks are performed on declarations also.
//params OPR_NR_UEOP:OPR_NR_TERN:OPR_NR_UEAS:EXP_NR_OVFB:OPR_NR_UCMP:OPR_NR_UREL:CST_NO_BWID:ARY_NR_LOPR {skip_declarations="no"}
 params OPR_NR_UEOP:OPR_NR_TERN:OPR_NR_UEAS:EXP_NR_OVFB:OPR_NR_UCMP:OPR_NR_UREL:CST_NO_BWID:ARY_NR_LOPR {skip_declarations="yes"}

// By default, the following check is not issued on indexed variables.
// If this parameter is set to 'no', then this check is performed on indexed variables also.
params EXP_NR_MXSU {skip_expr_in_index="yes" }
//params EXP_NR_MXSU {skip_expr_in_index="no"}

// By default, following check is not issued on parameter assigned or initial value
// If parameter is set to 'no' then this check is performed on assigned or initial value also.
// enum member initialization is taken as parameter initialization
//params MOD_NR_SYXZ {skip_param_value="no"}
params MOD_NR_SYXZ {skip_param_value="yes"}

// By default, following check is not issued on parameter assigned, initial value or instance parameters.
// If parameter is set to 'no' then this check is performed on all these.
//params CST_NO_BASE {skip_param_value="no"}
params CST_NO_BASE {skip_param_value="yes"}

// By default, the MOD_NR_SYXZ check is not issued for case default statements.
// If the 'skip_case_default_statement' parameter is set to 'no', this check is
// performed for the default statement as well. If this parameter is set to 'yes',
// this check is skipped for the default statement. If this parameter is set to
// 'x_only', this check is performed for 'z' value only in default statement.
//params MOD_NR_SYXZ {skip_case_default_statement="no"}
//params MOD_NR_SYXZ {skip_case_default_statement="x_only"}
params MOD_NR_SYXZ {skip_case_default_statement="yes"}

// By default, Superlint issues MOD_NR_SYXZ for 'z' detection inside tri-state logic.
// If the 'skip_tristate_logic' parameter is set to 'yes', the tool does not perform
// this check if logic resides inside tri-state logic. If this parameter is set to 'no',
// this check is issued for tri-state logic as well.
params MOD_NR_SYXZ {skip_tristate_logic="no"}
//params MOD_NR_SYXZ {skip_tristate_logic="yes"}

// By default, Superlint does not issue VAR_NR_RDBA for VHDL.
// If the "enable_vhdl_support" parameter is set to "yes", Superlint enables
// VAR_NR_RDBA checks for VHDL as well.
params VAR_NR_RDBA {enable_vhdl_support="no"}
//params VAR_NR_RDBA {enable_vhdl_support="yes"}

// By default, following check is not issued on component declaration
// If parameter is set to 'no' then this check is performed on component declaration also.
//params FNC_MS_AFPR {skip_component_declaration="no"}
params FNC_MS_AFPR {skip_component_declaration="yes"}


// By default, following checks are not performed on event expression used in always block sensitive list.
// if parameter 'skip_event_expression' is set to 'no' then these checks are performed on event expressions also.
//params OPR_NR_UEOP:OPR_NR_UEAS:OPR_NR_UCMP:OPR_NR_UREL {skip_event_expression="no"}
params OPR_NR_UEOP:OPR_NR_UEAS:OPR_NR_UCMP:OPR_NR_UREL {skip_event_expression="yes"}


// By default, following checks are not performed in 'if-condition' if 'for' loop index variable is part of an operand
// for ex. if(i == 2'b0); if i is 'for' loop index variable and its data type let say 'int' then OPR_NR_UCMP is not reported
// If parameter is set to 'no', these checks are performed in mentioned condition as well.
//params OPR_NR_UEOP:OPR_NR_TERN:OPR_NR_UEAS:OPR_NR_UCMP:OPR_NR_UREL {skip_loop_index_comparison="no"}
params OPR_NR_UEOP:OPR_NR_TERN:OPR_NR_UEAS:OPR_NR_UCMP:OPR_NR_UREL {skip_loop_index_comparison="yes"}

// By default, following checks are not performed on 'for' loop declaration statement (initial statement, condition, repetition)
// If parameter is set to 'no', these checks are performed in loop declaration statement as well.
//params ASG_NR_LMSB:OPR_NR_LOSD:ASG_MS_RTRU:ASG_NR_POVF:OPR_NR_UCMP:OPR_NR_UREL:OPR_NR_UEOP:OPR_NR_TERN:OPR_NR_UEAS {skip_loop_declaration="no"}
//params LOP_NR_MLPV:VAR_NR_RDBA:CAS_NR_DEFX {skip_loop_declaration="no"}
params ASG_NR_LMSB:OPR_NR_LOSD:ASG_MS_RTRU:ASG_NR_POVF:OPR_NR_UCMP:OPR_NR_UREL:OPR_NR_UEOP:OPR_NR_TERN:OPR_NR_UEAS {skip_loop_declaration="yes"}
params LOP_NR_MLPV:VAR_NR_RDBA:CAS_NR_DEFX {skip_loop_declaration="yes"}
params EXP_NR_USTS {skip_loop_declaration="no"}
//params EXP_NR_USTS {skip_loop_declaration="yes"}


// **************************************************************************
// ***************** Parameter to control Functional Combinational loop check
// **************************************************************************

params MOD_IS_FCMB {loop_count_limit="10"}
//params MOD_IS_FCMB {loop_count_limit="0"}

params MOD_IS_FCMB {include_latch_data="yes"}
//params MOD_IS_FCMB {include_latch_data="no"}


//****************************************************************
// ** Parameter to control the behavior of ASG_NR_POVF ***********
//****************************************************************
// By default this check is reported on statement like increment "a = a + constant"
// or decrement "a = a - constant". If this parameter is set to increment/decrement
// then this violation is not reported.

params ASG_NR_POVF {skip_statement=""}
 // params ASG_NR_POVF {skip_statement="increment:decrement"}

// If negative value is assigned to unsigned expression in a statement
// then by default minimum number of bits required to represent that
// negative value is taken in consideration.
// If this parameter is set to 'yes' then for every negative value
// assignment to unsigned expression will be considered as potential overflow.

params ASG_NR_POVF {report_all_negative_assignment_to_unsigned="no"}
// params ASG_NR_POVF {report_all_negative_assignment_to_unsigned="yes"}



//****************************************************************
// ** Parameter to control the behavior of FNC_NR_SYSV ***********
//****************************************************************
// The parameter controls the list of functions which are not allowed
// to be used.

params FNC_NR_SYSV {disallow_function_list=""}

// The "allow_funtion_list" parameter controls the list of functions
// that are allowed. All functions not listed are disallowed.
// Empty list means, everything is allowed

params FNC_NR_SYSV {allow_function_list=""}


/****************************************************************
// ** Parameter to control the behavior of MOD_NR_CNDO ***********
//****************************************************************
// This parameter controls the reporting of this rule for non constants operands.
// Additionally, the operands here need to be 4-state non constants. This rule
// is not reported for 2-state data types.
// When the parameter "ignore_non_const" is "yes", this check will not be reported
// when the "===" or "!==" operator is used but the operands are 4-state non
// constants.

//params MOD_NR_CNDO {ignore_non_const="no"}
params MOD_NR_CNDO {ignore_non_const="yes"}

// **************************************************************************
// ***************** Parameter to control the behavior of FLP_NO_SRST
// **************************************************************************
// This parameter controls the behavior of FLP_NO_SRST. If value of parameter
// is set to "yes", tool will report check on instance level. If value is set
// to "no", tool will report check on module level. The default value of
// 'check_on_instance' is set to "no".
//params FLP_NO_SRST {check_on_instance="yes"}
params FLP_NO_SRST {check_on_instance="no"}

// This parameter controls the behavior of FLP_NO_SRST. If value of parameter
// is set to "yes", tool will not report when the data pin is getting constant
//  value.If value is set to "no", tool will report check even when the data
// pin of flop gets constant value. The default value of 'ignore_constant_flops'
// is set to "no"
//params FLP_NO_SRST {ignore_constant_flops="yes"}
params FLP_NO_SRST {ignore_constant_flops="no"}

// **************************************************************
// ******* Parameter for controlling CLK_NS_EDMX **********
// **************************************************************
//This parameter controls the behavior of CLK_NS_EDMX. If the value of parameter primary_edge
//is set to "posedge", then tool will report CLK_NS_EDMX check for negedge usage of clock.
//When value of parameter is set to "negedge", then tool will report CLK_NS_EDMX check for posedge usage of clock.
//When value of parameter is set to "none", then tool will report CLK_NS_EDMX check both for posedge and negedge usage of clock.
//By default, value is "posedge".
//params CLK_NS_EDMX {primary_edge ="negedge"}
//params CLK_NS_EDMX {primary_edge ="none"}
params CLK_NS_EDMX {primary_edge="posedge"}

// **************************************************************************
// ***************** Parameter to control the behavior of EXP_NR_ITYC
// **************************************************************************
// This parameter controls the behavior of EXP_NR_ITYC. If value of parameter
// is set to "yes", tool will not report violations on operations. If value is set
// to "no", tool will report violation on operations. The default value of
// 'skip_operation' is set to "no".
//params EXP_NR_ITYC {skip_operation="yes"}
params EXP_NR_ITYC {skip_operation="no"}

// **************************************************************************
// ***************** Parameter to control the behavior of FLT_IS_HTST
// **************************************************************************
// This parameter controls the behavior of FLT_IS_HTST.
// This parameter limits the number of FLT_IS_HTST violations the tool reports.
// Set the value of this parameter to the maximum number of violations you want reported.
// The tool will not report FLT_IS_HTST violations that exceed the specified value.
// If the value of this parameter is set to -1 , the tool reports all FLT_IS_HTST violations.
// By default, the value of this parameter is 250.
params FLT_IS_HTST {max_limit = 250}

// This parameter controls the behavior of FLT_IS_HTST.
// If the value of this parameter is "no", FLT_IS_HTST violations, that is, hard to test faults, will contribute to
// test coverage estimation. If the value is "yes", FLT_IS_HTST violations will not contribute to test coverage estimation.
// By default, the value of "exclude_in_coverage_estimation" is "no".
//params FLT_IS_HTST {exclude_in_coverage_estimation = "yes"}
params FLT_IS_HTST {exclude_in_coverage_estimation = "no"}

// **************************************************************************************
// ***************** Parameter to control constant propagation through flip-flop
// **************************************************************************************
// This parameter controls the behavior of constant propagation through flip-flops.If the value of parameter
// is set to "yes", tool will propagate the constant through flop. If value is set
// to "no", tool will not propagate the constant through flop . The default value of
// the parameter  is set to "no".

//params SUPERLINT {allow_constant_propagation_through_latch="yes"}
params SUPERLINT {allow_constant_propagation_through_flip_flop="no"}


// **************************************************************************************
// ***************** Parameter to control constant propagation through latch
// **************************************************************************************
// This parameter controls the behavior of constant propagation through latches.If the value of parameter
// is set to "yes", tool will propagate the constant through latch. If value is set
// to "no", tool will not propagate the constant through latch . The default value of
// the parameter  is set to "no".

//params SUPERLINT {allow_constant_propagation_through_latch="yes"}
params SUPERLINT {allow_constant_propagation_through_latch="no"}

// **************************************************************************************
// ***************** Parameter to control processing of -y/-v option
// **************************************************************************************
// This parameter controls whether to skip violations inside -y/-v files provided with the "analyze" command.
// If the value of this parameter is set to "compile_v_option", the tool does not issue violations inside modules processed with the -v option.
// If the value of this parameter is set to "compile_y_option", the tool does not issue violations inside modules processed with the -y option.
// If the value of parameter is set to "both", the tool does not issue violations inside modules processed witheither -v or -y options.
// If the value of parameter is set to "none", the tool issues violations inside modules processed with both -v and -y options.
// The default value of the parameter is "compile_v_option".
params SUPERLINT {skip_library_modules="compile_v_option"}
//params SUPERLINT {skip_library_modules="compile_v_option|compile_y_option|both|none"}


// **************************************************************************************
// ***************** Parameter to skip unloaded clock gates
// **************************************************************************************
// This parameter controls the behavior of unloaded clock gates. If the value of this parameter
// is set to "yes", the tool ignores unloaded clock gates. If the value is set
// to "no", the tool detects unloaded clock gates. The default value of this
// parameter is "no".

//params SUPERLINT {skip_unloaded_clock_gates="yes"}
params SUPERLINT {skip_unloaded_clock_gates="no"}

// ********************************************************************
// ***************Parameter to disable checking unused code************
// ********************************************************************
// The "skip_checking_unused_code" parameter disables checks of unused modules,
// functions, and tasks. If the value of this parameter is "yes", the tool
// skips checks for unused modules, functions, and tasks. By default, the value
// is set to "no".

params SUPERLINT {skip_checking_unused_code ="no"}
//params SUPERLINT {skip_checking_unused_code ="yes"}

// *****************************************************************************
// ************ Parameter for controlling latch data in loops  *****************
// *****************************************************************************
//  Messages for loops passing through the data of a latch are issued
//  when the value of the "include_latch_data_for_loops" parameter is "yes".
//  Set this parameter to "no" to disable such messages.
//  The default is "yes".

params SUPERLINT {include_latch_data_for_loops="yes"}
//params SUPERLINT {include_latch_data_for_loops="no"}

// ******************************************************************
// *** Parameter for controlling enumerated combo loops processed ***
// ******************************************************************
// This parameter controls the supported loops processed limit.
// By default, "processed_loops_limit" is set to "-1", denoting no limit.
// Modify this value to change the limit.
params SUPERLINT { processed_loops_limit ="-1"}

// **************************************************************************
// ***************** Parameter to control the behavior of FLP_IS_GTCK
// **************************************************************************
// This parameter controls the behavior of FLP_IS_GTCK. The parameter can
// control which type of combinational logic are not allowed in clock tree.
// 'all' issues violations for all type of combinationational logic.
// The defult of value of this parameter is 'all'.
//params FLP_IS_GTCK {disallowed_combinational_logic="and:nand:or:nor:xor:xnor:mux:tri:multi-driven:others"}
params FLP_IS_GTCK{disallowed_combinational_logic="all"}

// **************************************************************************
// ***************** Parameter to control the behavior of INP_NR_IOUT
// **************************************************************************
// This "ignore_inout_as_input_ports" parameter controls the behavior of INP_NR_IOUT. 
// This parameter controls whether the violation should be issued for inout ports 
// that are behaving as input ports.
// The defult of value of this parameter is 'yes'.
//params INP_NR_IOUT {ignore_inout_as_input_ports="no"}
params INP_NR_IOUT{ignore_inout_as_input_ports="yes"}
