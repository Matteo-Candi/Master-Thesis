# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(lst):
    sum = 0
    for i in range(len(lst)):
        if i % 3 == 0:
            sum += lst[i] * lst[i]
        elif i % 4 == 0:
            sum += lst[i] * lst[i] * lst[i]
        else:
            sum += lst[i]
    return sum
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
    ret = are_equivalent(testfunc([1,2,3]),6)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([1,4,9]),14)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([]),0)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([-1,-1,-1,-1,-1,-1,-1,-1,-1]),-3)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([-56,-99,1,0,-2]),3030)
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
