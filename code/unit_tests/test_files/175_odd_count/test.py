# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(lst):
    results = []
    originalStr = "the number of odd elements in the string i of the input."
    for s in lst:
        sum = 0
        for d in s:
            if d.isdigit() and int(d) % 2 == 1:
                sum += 1
        result = ""
        for c in originalStr:
            if c == 'i':
                result += str(sum)
            else:
                result += c
        results.append(result)
    return results
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
    ret = are_equivalent(testfunc(["1234567"]),["the number of odd elements 4n the str4ng 4 of the 4nput."])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(["3","11111111"]),["the number of odd elements 1n the str1ng 1 of the 1nput.","the number of odd elements 8n the str8ng 8 of the 8nput."])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(["271","137","314"]),["the number of odd elements 2n the str2ng 2 of the 2nput.","the number of odd elements 3n the str3ng 3 of the 3nput.","the number of odd elements 2n the str2ng 2 of the 2nput."])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(["5","15"]),["the number of odd elements 1n the str1ng 1 of the 1nput.","the number of odd elements 2n the str2ng 2 of the 2nput."])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(["9"]),["the number of odd elements 1n the str1ng 1 of the 1nput."])
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
