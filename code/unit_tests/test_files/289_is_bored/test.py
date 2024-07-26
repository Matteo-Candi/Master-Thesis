# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(s):
    isStart = True
    sum = 0
    for i in range(len(s)):
        if s[i] == '.' or s[i] == '?' or s[i] == '!':
            isStart = True
        elif isStart:
            if s[i] == ' ':
                continue
            if s.startswith("I ", i):
                sum += 1
            isStart = False
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
    ret = are_equivalent(testfunc("Hello world"),0)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("Is the sky blue?"),0)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("I love It !"),1)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("bIt"),0)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("I feel good today. I will be productive. will kill It"),2)
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
