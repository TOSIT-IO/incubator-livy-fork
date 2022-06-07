# Test notes

- [Code changes](#code-changes)
- [Test Command](#test-command)
- [Test results](#test-results)
- [Test failures and solutions](#test-failures-and-solutions)
  - [livy-repl\_(2.11|2.12)](#livy-repl_211212)

## Code changes

1. Livy version: `0.8.0-incubating-SNAPSHOT` → `0.8.0-incubating-TDP-0.1.0-SNAPSHOT`
2. Scala 2.12 version: `2.12.10` → `2.12.15`
3. Plugin `net.alchim31.maven.scala-maven-plugin` version: `4.2.0` → `4.5.4`
4. Add versions `3.1` and `3.2` in `_defaultSparkScalaVersion` map in [LivySparkUtils.scala](../server/src/main/scala/org/apache/livy/utils/LivySparkUtils.scala).
5. Add versions `3.1.1` and `3.2.2` in list of supported Spark versions in [LivySparkUtilsSuite.scala](../server/src/test/scala/org/apache/livy/utils/LivySparkUtilsSuite.scala).

Those changes are based on [incubator-livy#334](https://github.com/apache/incubator-livy/pull/334).

## Test Command

```bash
mvn test --fail-never
```

## Test results

| Package             | Tests   | Failures | Skipped | Success rate |
| ------------------- | ------- | -------- | ------- | ------------ |
| livy-api            | 7       | 0        | 0       | 100%         |
| livy-client-common  | 18      | 0        | 0       | 100%         |
| livy-client-http    | 16      | 0        | 0       | 100%         |
| livy-rsc            | 40      | 0        | 0       | 100%         |
| livy-server         | 164     | 0        | 2       | 98.78%       |
| livy-core_2.11      | 2       | 0        | 0       | 100%         |
| livy-core_2.12      | 2       | 0        | 0       | 100%         |
| livy-repl_2.11      | 109     | 1        | 0       | 99.083%      |
| livy-repl_2.12      | 109     | 1        | 0       | 99.083%      |
| livy-scala-api_2.11 | 17      | 0        | 0       | 99.083%      |
| livy-scala-api_2.12 | 17      | 0        | 0       | 99.083%      |
| livy-python-api     | 12      | 0        | 0       | 100%         |
| **Total**           | **513** | **2**    | **2**   | **99.220%**  |

## Test failures and solutions

### livy-repl\_(2.11|2.12)

#### Class: `org.apache.livy.repl.Python2InterpreterSpec`

- Error:

  ```
  ExecuteSuccess(JObject(List((text/plain,JString(?))))) did not equal ExecuteSuccess(JObject(List((text/plain,JString(☺)))))
  ```

  - Status: 2 failures ignored
  - Tests (2 failures):

    - `should print unicode correctly` (scala-2.11)
    - `should print unicode correctly` (scala-2.12)

  - Cause: ASCII character issue
  - Solution: None
  - Stack trace:

    ```
    org.scalatest.exceptions.TestFailedException: ExecuteSuccess(JObject(List((text/plain,JString(?))))) did not equal ExecuteSuccess(JObject(List((text/plain,JString(☺)))))
      at org.scalatest.MatchersHelper$.indicateFailure(MatchersHelper.scala:343)
      at org.scalatest.Matchers$ShouldMethodHelper$.shouldMatcher(Matchers.scala:6723)
      at org.scalatest.Matchers$AnyShouldWrapper.should(Matchers.scala:6771)
      at org.apache.livy.repl.Python2InterpreterSpec$$anonfun$16$$anonfun$apply$mcV$sp$16.apply(PythonInterpreterSpec.scala:266)
      at org.apache.livy.repl.Python2InterpreterSpec$$anonfun$16$$anonfun$apply$mcV$sp$16.apply(PythonInterpreterSpec.scala:265)
      at org.apache.livy.repl.BaseInterpreterSpec.withInterpreter(BaseInterpreterSpec.scala:32)
      at org.apache.livy.repl.Python2InterpreterSpec$$anonfun$16.apply$mcV$sp(PythonInterpreterSpec.scala:265)
      at org.apache.livy.repl.Python2InterpreterSpec$$anonfun$16.apply(PythonInterpreterSpec.scala:265)
      at org.apache.livy.repl.Python2InterpreterSpec$$anonfun$16.apply(PythonInterpreterSpec.scala:265)
      at org.scalatest.OutcomeOf$class.outcomeOf(OutcomeOf.scala:85)
      at org.scalatest.OutcomeOf$.outcomeOf(OutcomeOf.scala:104)
      at org.scalatest.Transformer.apply(Transformer.scala:22)
      at org.scalatest.Transformer.apply(Transformer.scala:20)
      at org.scalatest.FlatSpecLike$$anon$1.apply(FlatSpecLike.scala:1682)
      at org.apache.livy.LivyBaseUnitTestSuite$class.withFixture(LivyBaseUnitTestSuite.scala:29)
      at org.apache.livy.repl.BaseInterpreterSpec.withFixture(BaseInterpreterSpec.scala:24)
      at org.scalatest.FlatSpecLike$class.invokeWithFixture$1(FlatSpecLike.scala:1679)
      at org.scalatest.FlatSpecLike$$anonfun$runTest$1.apply(FlatSpecLike.scala:1692)
      at org.scalatest.FlatSpecLike$$anonfun$runTest$1.apply(FlatSpecLike.scala:1692)
      at org.scalatest.SuperEngine.runTestImpl(Engine.scala:286)
      at org.scalatest.FlatSpecLike$class.runTest(FlatSpecLike.scala:1692)
      at org.scalatest.FlatSpec.runTest(FlatSpec.scala:1685)
      at org.scalatest.FlatSpecLike$$anonfun$runTests$1.apply(FlatSpecLike.scala:1750)
      at org.scalatest.FlatSpecLike$$anonfun$runTests$1.apply(FlatSpecLike.scala:1750)
      at org.scalatest.SuperEngine$$anonfun$traverseSubNodes$1$1.apply(Engine.scala:393)
      at org.scalatest.SuperEngine$$anonfun$traverseSubNodes$1$1.apply(Engine.scala:381)
      at scala.collection.immutable.List.foreach(List.scala:392)
      at org.scalatest.SuperEngine.traverseSubNodes$1(Engine.scala:381)
      at org.scalatest.SuperEngine.org$scalatest$SuperEngine$$runTestsInBranch(Engine.scala:376)
      at org.scalatest.SuperEngine.runTestsImpl(Engine.scala:458)
      at org.scalatest.FlatSpecLike$class.runTests(FlatSpecLike.scala:1750)
      at org.scalatest.FlatSpec.runTests(FlatSpec.scala:1685)
      at org.scalatest.Suite$class.run(Suite.scala:1124)
      at org.scalatest.FlatSpec.org$scalatest$FlatSpecLike$$super$run(FlatSpec.scala:1685)
      at org.scalatest.FlatSpecLike$$anonfun$run$1.apply(FlatSpecLike.scala:1795)
      at org.scalatest.FlatSpecLike$$anonfun$run$1.apply(FlatSpecLike.scala:1795)
      at org.scalatest.SuperEngine.runImpl(Engine.scala:518)
      at org.scalatest.FlatSpecLike$class.run(FlatSpecLike.scala:1795)
      at org.scalatest.FlatSpec.run(FlatSpec.scala:1685)
      at org.scalatest.Suite$class.callExecuteOnSuite$1(Suite.scala:1187)
      at org.scalatest.Suite$$anonfun$runNestedSuites$1.apply(Suite.scala:1234)
      at org.scalatest.Suite$$anonfun$runNestedSuites$1.apply(Suite.scala:1232)
      at scala.collection.IndexedSeqOptimized$class.foreach(IndexedSeqOptimized.scala:33)
      at scala.collection.mutable.ArrayOps$ofRef.foreach(ArrayOps.scala:186)
      at org.scalatest.Suite$class.runNestedSuites(Suite.scala:1232)
      at org.scalatest.tools.DiscoverySuite.runNestedSuites(DiscoverySuite.scala:30)
      at org.scalatest.Suite$class.run(Suite.scala:1121)
      at org.scalatest.tools.DiscoverySuite.run(DiscoverySuite.scala:30)
      at org.scalatest.tools.SuiteRunner.run(SuiteRunner.scala:45)
      at org.scalatest.tools.Runner$$anonfun$doRunRunRunDaDoRunRun$1.apply(Runner.scala:1349)
      at org.scalatest.tools.Runner$$anonfun$doRunRunRunDaDoRunRun$1.apply(Runner.scala:1343)
      at scala.collection.immutable.List.foreach(List.scala:392)
      at org.scalatest.tools.Runner$.doRunRunRunDaDoRunRun(Runner.scala:1343)
      at org.scalatest.tools.Runner$$anonfun$runOptionallyWithPassFailReporter$2.apply(Runner.scala:1012)
      at org.scalatest.tools.Runner$$anonfun$runOptionallyWithPassFailReporter$2.apply(Runner.scala:1011)
      at org.scalatest.tools.Runner$.withClassLoaderAndDispatchReporter(Runner.scala:1509)
      at org.scalatest.tools.Runner$.runOptionallyWithPassFailReporter(Runner.scala:1011)
      at org.scalatest.tools.Runner$.main(Runner.scala:827)
      at org.scalatest.tools.Runner.main(Runner.scala)
    ```
