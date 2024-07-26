# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(words):
    max = ""
    maxLength = 0
    for word in words:
        unique = set(word)
        if len(unique) > maxLength or (len(unique) == maxLength and word < max):
            max = word
            maxLength = len(unique)
    return max
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
    ret = are_equivalent(testfunc(["name","of","string"]),"string")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(["name","enam","game"]),"enam")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(["aaaaaaa","bb","cc"]),"aaaaaaa")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(["we","are","gonna","rock"]),"gonna")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(["this","is","a","prrk"]),"this")
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
