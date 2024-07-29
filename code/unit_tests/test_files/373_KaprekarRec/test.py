# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(n, prev):
    if n == 0:
        return 0
    prev = n
    digits = [0]*4
    for i in range(4):
        digits[i] = n % 10
        n = n // 10
    digits.sort()
    asc = 0
    for i in range(4):
        asc = asc * 10 + digits[i]
    digits.sort(reverse=True)
    desc = 0
    for i in range(3, -1, -1):
        desc = desc * 10 + digits[i]
    diff = abs(asc - desc)
    if diff == prev:
        return diff
    return testfunc(diff, prev)
# End here


def serialize_list(obj) -> str:
    list_str = ["["]
    for item in obj:
        list_str.append(serialize_obj(item))
        list_str.append(",")
    list_str[-1] = "]"
    return "".join(list_str)


def serialize_dict(obj) -> str:
    m = OrderedDict(sorted(obj.items()))
    dict_str = ["{"]
    for key, value in m.items():
        dict_str.append(serialize_obj(key))
        dict_str.append(":")
        dict_str.append(serialize_obj(value))
        dict_str.append(",")
    dict_str[-1] = "}"
    return "".join(dict_str)


def serialize_obj(obj) -> str:
    if obj is None:
        return "null"
    if isinstance(obj, int) or isinstance(obj, float):
        return "{0:.6f}".format(obj)
    if isinstance(obj, str):
        return '"' + obj + '"'
    if isinstance(obj, bool):
        return str(obj)
    if isinstance(obj, list):
        return serialize_list(obj)
    if isinstance(obj, dict):
        return serialize_dict(obj)
    raise Exception("Unrecognized Type!")


def are_equivalent(o1, o2) -> bool:
    print(serialize_obj(o1)+" "+serialize_obj(o2))
    return serialize_obj(o1) == serialize_obj(o2)


def start():
    ret = False
    count = 0
    total = 0
    # Write the unit tests here
    total += 1
    ret = are_equivalent(testfunc(0,0),0)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(1234,0),6174)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(1111,0),0)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(5555,0),0)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(9876,0),6174)
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
