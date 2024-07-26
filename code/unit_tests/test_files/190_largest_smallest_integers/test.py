# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(lst):
    maxNeg = 0
    minPos = 0
    for n in lst:
        if n < 0 and (maxNeg == 0 or n > maxNeg):
            maxNeg = n
        if n > 0 and (minPos == 0 or n < minPos):
            minPos = n
    return [maxNeg, minPos]
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
    ret = are_equivalent(testfunc([2,4,1,3,5,7]),[0,1])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([2,4,1,3,5,7,0]),[0,1])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([1,3,2,4,5,6,-2]),[-2,1])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([4,5,3,6,2,7,-7]),[-7,2])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([7,3,8,4,9,2,5,-9]),[-9,2])
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
