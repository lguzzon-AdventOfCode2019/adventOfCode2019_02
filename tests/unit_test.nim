
import unittest

import adventOfCode2019_02
import adventOfCode2019_02/consts


suite "unit-test suite":
    test "getMessage":
        assert(cHelloWorld == getMessage())
