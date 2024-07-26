# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(arr, k):
    sum = 0
    for i in range(k):
        if arr[i] >= -99 and arr[i] <= 99:
            sum += arr[i]
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
    ret = are_equivalent(testfunc([1,-2,-3,41,57,76,87,88,99],3),-4)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([111,121,3,4000,5,6],2),0)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([11,21,3,90,5,6,7,8,9],4),125)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([111,21,3,4000,5,6,7,8,9],4),24)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([1],1),1)
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
