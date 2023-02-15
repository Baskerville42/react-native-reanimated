import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

interface Props {
  isAutofillExtensionContext: boolean;
  serviceIdentifiers: string[];
}

const AutofillExtension: React.FC<Props> = ({
  isAutofillExtensionContext,
  serviceIdentifiers = [],
}) => {
  return (
    <View style={styles.view}>
      <Text style={styles.title}>Hello, AutofillExtension User!</Text>

      <Text style={styles.heading}>{`Is Autofill Extension Context? ${
        isAutofillExtensionContext ? 'YES' : 'NO'
      }`}</Text>

      {isAutofillExtensionContext && Boolean(serviceIdentifiers.length) && (
        <View>
          <Text style={styles.heading}>Service identifiers:</Text>
          <Text>{serviceIdentifiers.join(', ')}</Text>
        </View>
      )}
    </View>
  );
};

export default AutofillExtension;

const styles = StyleSheet.create({
  view: {
    flex: 1,
    flexDirection: 'column',
    backgroundColor: 'yellow',
    alignItems: 'center',
    justifyContent: 'space-evenly',
  },
  title: {
    fontSize: 20,
    color: 'red',
  },
  heading: {
    fontSize: 14,
    fontWeight: 'bold',
  },
});
