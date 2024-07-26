# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(start, end, n, s):
    if start >= end:
        return start
    mid = start + (end - start) // 2
    totalSum = n * (n + 1) // 2
    midSum = mid * (mid + 1) // 2
    if totalSum - midSum <= s:
        return testfunc(start, mid, n, s)
    return testfunc(mid + 1, end, n, s)
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
    ret = are_equivalent(testfunc(0,10,10,4),10)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(0,100,100,4000),46)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(0,50,50,300),44)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(0,50,50,98),49)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(0,50,50,500),39)
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
