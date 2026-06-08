// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Protobuf encoding/decoding for Geode wire protocol.
// Wire format: 4-byte Big Endian length prefix + protobuf message body.
// This module re-exports sub-modules for backward compatibility.

// Sub-modules
pub const types = @import("proto/types.zig");
pub const encode = @import("proto/encode.zig");
pub const decode = @import("proto/decode.zig");

// Re-export wire type constants
pub const WIRE_VARINT = types.WIRE_VARINT;
pub const WIRE_FIXED64 = types.WIRE_FIXED64;
pub const WIRE_BYTES = types.WIRE_BYTES;
pub const WIRE_FIXED32 = types.WIRE_FIXED32;

// Re-export security limits
pub const MAX_STRING_FIELD_SIZE = types.MAX_STRING_FIELD_SIZE;
pub const MAX_ROWS_PER_PAGE = types.MAX_ROWS_PER_PAGE;

// Re-export message types
pub const HelloRequest = types.HelloRequest;
pub const HelloResponse = types.HelloResponse;
pub const Param = types.Param;
pub const ExecuteRequest = types.ExecuteRequest;
pub const PullRequest = types.PullRequest;
pub const ColumnDefinition = types.ColumnDefinition;
pub const SchemaDefinition = types.SchemaDefinition;
pub const Value = types.Value;
pub const Row = types.Row;
pub const DataPage = types.DataPage;
pub const ProtoError = types.ProtoError;
pub const Status = types.Status;
pub const ExecutionMetrics = types.ExecutionMetrics;
pub const ExecutionResponse = types.ExecutionResponse;
pub const PullResponse = types.PullResponse;
pub const PingRequest = types.PingRequest;
pub const PingResponse = types.PingResponse;
pub const BeginRequest = types.BeginRequest;
pub const BeginResponse = types.BeginResponse;
pub const CommitRequest = types.CommitRequest;
pub const CommitResponse = types.CommitResponse;
pub const RollbackRequest = types.RollbackRequest;
pub const RollbackResponse = types.RollbackResponse;
pub const SavepointRequest = types.SavepointRequest;
pub const SavepointResponse = types.SavepointResponse;
pub const RollbackToRequest = types.RollbackToRequest;
pub const RollbackToResponse = types.RollbackToResponse;
pub const QuicClientMessage = types.QuicClientMessage;
pub const QuicServerMessage = types.QuicServerMessage;

// Re-export encoding functions
pub const encodeVarint = encode.encodeVarint;
pub const encodeTag = encode.encodeTag;
pub const encodeString = encode.encodeString;
pub const encodeBool = encode.encodeBool;
pub const encodeInt64 = encode.encodeInt64;
pub const encodeUint32 = encode.encodeUint32;
pub const encodeUint64 = encode.encodeUint64;
pub const encodeDouble = encode.encodeDouble;
pub const encodeSubmessage = encode.encodeSubmessage;
pub const encodeQuicClientMessage = encode.encodeQuicClientMessage;
pub const encodeWithLengthPrefix = encode.encodeWithLengthPrefix;

// Re-export decoding functions
pub const decodeVarint = decode.decodeVarint;
pub const decodeTag = decode.decodeTag;
pub const skipField = decode.skipField;
pub const decodeString = decode.decodeString;
pub const decodeBytesField = decode.decodeBytesField;
pub const decodeBool = decode.decodeBool;
pub const decodeInt64 = decode.decodeInt64;
pub const decodeUint32 = decode.decodeUint32;
pub const decodeUint64 = decode.decodeUint64;
pub const decodeDoubleFixed = decode.decodeDoubleFixed;
pub const decodeLengthPrefix = decode.decodeLengthPrefix;
pub const decodeQuicServerMessage = decode.decodeQuicServerMessage;

// Pull in tests from sub-modules. `refAllDecls` references decls for
// type-checking; the explicit `_ = @import(...)` lines force the test
// runner to also execute the `test {}` blocks defined in each sub-module
// (refAllDecls alone does not pull in nested-file tests).
test {
    const std = @import("std");
    std.testing.refAllDecls(@This());
    _ = @import("proto/types.zig");
    _ = @import("proto/encode.zig");
    _ = @import("proto/decode.zig");
}
