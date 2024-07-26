# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(arr):
    bin = []
    for i in arr:
        b = 0
        n = abs(i)
        while n > 0:
            b += n % 2
            n //= 2
        bin.append(b)
    for i in range(len(arr)):
        for j in range(1, len(arr)):
            if bin[j] < bin[j - 1] or (bin[j] == bin[j - 1] and arr[j] < arr[j - 1]):
                bin[j], bin[j - 1] = bin[j - 1], bin[j]
                arr[j], arr[j - 1] = arr[j - 1], arr[j]
    return arr

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
    ret = are_equivalent(testfunc([1,5,2,3,4]),[1,2,4,3,5])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([-2,-3,-4,-5,-6]),[-4,-2,-6,-5,-3])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([1,0,2,3,4]),[0,1,2,4,3])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([]),[])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([2,4,8,16,32]),[2,4,8,16,32])
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
