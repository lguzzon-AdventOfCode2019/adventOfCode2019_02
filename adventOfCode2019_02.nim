import parsecsv
from streams import newFileStream
import strutils

type
    tMemory = array[100000, int64]


proc memoryFromInput(aInput: string = "input"): tMemory =
    var lFileStream = aInput.newFileStream(fmRead)
    if lFileStream == nil:
        quit("cannot open the file" & aInput)
    var lCsvParser: CsvParser
    lCsvParser.open(lFileStream, aInput)
    var lIndex = 0
    while lCsvParser.readRow:
        # echo "new row: "
        for val in lCsvParser.row.items:
            result[lIndex] = val.parseBiggestInt
            lIndex += 1
            # echo "##", val, "##"
    close(lCsvParser)


proc runProgram(aMemory: var tMemory): int64 =
    var lInstructionPointer = 0
    while true:
        let lCurrentValue = aMemory[lInstructionPointer]
        case lCurrentValue

        of 1:
            let lA = aMemory[lInstructionPointer + 1]
            let lB = aMemory[lInstructionPointer + 2]
            let lC = aMemory[lInstructionPointer + 3]
            aMemory[lC] = (aMemory[lA] + aMemory[lB])
            lInstructionPointer += 4

        of 2:
            let lA = aMemory[lInstructionPointer + 1]
            let lB = aMemory[lInstructionPointer + 2]
            let lC = aMemory[lInstructionPointer + 3]
            aMemory[lC] = (aMemory[lA] * aMemory[lB])
            lInstructionPointer += 4

        else:
            break
    return aMemory[0]


proc partOne =
    # var gMemory = memoryFromInput("testInput_00")
    var lMemory: tMemory = memoryFromInput()

    lMemory[1] = 12
    lMemory[2] = 2

    echo "partOne $1"%[$runProgram(lMemory)]

proc partTwo =
    var lInput: tMemory = memoryFromInput()
    var lNoun: int64 = 0
    while (lNoun < 100):
        var lVerb: int64 = 0
        while (lVerb < 100):
            var lMemory = lInput
            lMemory[1] = lNoun
            lMemory[2] = lVerb
            if (19690720 == runProgram(lMemory)):
                let lResult = (100 * lNoun + lVerb)
                echo "partTwo $1"%[$lResult]
                return
            lVerb += 1
        lNoun += 1


partOne() #4023471
partTwo() #8051
