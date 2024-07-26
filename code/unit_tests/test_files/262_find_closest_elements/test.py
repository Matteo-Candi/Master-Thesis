# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(numbers):
    closestPair = [numbers[0], numbers[1]]
    distance = abs(numbers[0] - numbers[1])
    for i in range(len(numbers)):
        for j in range(i + 1, len(numbers)):
            if abs(numbers[i] - numbers[j]) < distance:
                closestPair[0] = numbers[i]
                closestPair[1] = numbers[j]
                distance = abs(numbers[i] - numbers[j])
    closestPair.sort()
    return closestPair

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
    ret = are_equivalent(testfunc([1.0,2.0,3.9,4.0,5.0,2.2]),[3.9,4.0])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([1.0,2.0,5.9,4.0,5.0]),[5.0,5.9])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([1.0,2.0,3.0,4.0,5.0,2.2]),[2.0,2.2])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([1.0,2.0,3.0,4.0,5.0,2.0]),[2.0,2.0])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([1.1,2.2,3.1,4.1,5.1]),[2.2,3.1])
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
