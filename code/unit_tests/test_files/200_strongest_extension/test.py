# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(className, extensions):
    strongest = ""
    max = float('-inf')
    for extension in extensions:
        strength = 0
        for chr in extension:
            if chr.isupper():
                strength += 1
            if chr.islower():
                strength -= 1
        if strength > max:
            max = strength
            strongest = extension
    return className + '.' + strongest
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
    ret = are_equivalent(testfunc("Watashi",["tEN","niNE","eIGHt8OKe"]),"Watashi.eIGHt8OKe")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("Boku123",["nani","NazeDa","YEs.WeCaNe","32145tggg"]),"Boku123.YEs.WeCaNe")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("finNNalLLly",["Die","NowW","Wow","WoW"]),"finNNalLLly.WoW")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("_",["Bb","91245"]),"_.Bb")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("Sp",["671235","Bb"]),"Sp.671235")
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
