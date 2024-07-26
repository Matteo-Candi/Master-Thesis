# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(lst):
    largest = 0
    for n in lst:
        if n > largest:
            prime = True
            for i in range(2, n):
                if n % i == 0:
                    prime = False
                    break
            if prime:
                largest = n
    sum = 0
    s = str(largest)
    for i in range(len(s)):
        sum += int(s[i])
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
    ret = are_equivalent(testfunc([0,3,2,1,3,5,7,4,5,5,5,2,181,32,4,32,3,2,32,324,4,3]),10)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([1,0,1,8,2,4597,2,1,3,40,1,2,1,2,4,2,5,1]),25)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([0,724,32,71,99,32,6,0,5,91,83,0,5,6]),11)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([0,81,12,3,1,21]),3)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([8191]),19)
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
