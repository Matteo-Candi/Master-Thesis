# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(n, k):
    v = []
    while n % 2 == 0:
        v.append(2)
        n //= 2
    if len(v) >= k:
        return True
    for i in range(3, int(n**0.5) + 1, 2):
        while n % i == 0:
            n //= i
            v.append(i)
        if len(v) >= k:
            return True
    if n > 2:
        v.append(n)
    if len(v) >= k:
        return True
    return False

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
    ret = are_equivalent(testfunc(1024,10),True)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(1024,11),False)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(32,4),True)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(38,5),False)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(3,2),False)
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
