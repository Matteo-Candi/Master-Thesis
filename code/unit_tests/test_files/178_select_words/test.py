# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(s, n):
    vowels = "aeiouAEIOU"
    current = ""
    result = []
    consonantNum = 0
    for i in range(len(s) + 1):
        if i == len(s) or s[i] == ' ':
            if consonantNum == n:
                result.append(current)
            current = ""
            consonantNum = 0
        else:
            current += s[i]
            if vowels.find(s[i]) == -1:
                consonantNum += 1
    return result

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
    ret = are_equivalent(testfunc("Mary had a little lamb",4),["little"])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("Mary had a little lamb",3),["Mary","lamb"])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("simple white space",2),[])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("Hello world",4),["world"])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("a b c d e f",1),["b","c","d","f"])
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
