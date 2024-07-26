# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(a, b, x1, y1):
    g = a / 2
    f = b / 2
    if g - x1 == 0:
        return -1
    slope = (f - y1) / (g - x1)
    if slope == 0:
        return -2
    return slope
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
    ret = are_equivalent(testfunc(10.0,6.0,5.0,0.0),-1.0)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(10.0,6.0,0.0,3.0),-2.0)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(10.0,10.0,3.0,4.0),0.5)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(10.0,10.0,4.0,3.0),2.0)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(28.0,28.0,5.0,13.0),0.111111)
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
