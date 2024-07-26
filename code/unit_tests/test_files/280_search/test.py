# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(lst):
    counter = {}
    for i in lst:
        counter[i] = counter.get(i, 0) + 1
    ans = -1
    for item in counter.items():
        if item[1] >= item[0] and item[0] > ans:
            ans = item[0]
    return ans
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
    ret = are_equivalent(testfunc([2,7,8,8,4,8,7,3,9,6,5,10,4,3,6,7,1,7,4,10,8,1]),1)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([6,7,1,8,8,10,5,8,5,3,10]),1)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([8,8,3,6,5,6,4]),-1)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([8,8,10,6,4,3,5,8,2,4,2,8,4,6,10,4,2,1,10,2,1,1,5]),4)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([9,7,7,2,4,7,2,10,9,7,5,7,2]),2)
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
